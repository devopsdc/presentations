module Parslet::Bytecode
  # Matches the string and pushes the result on the stack (looks like the
  # string, but is really the slice that was matched).
  #
  Match = Struct.new(:str) do
    def initialize(str)
      super
      @mismatch_error_prefix = "Expected #{str.inspect}, but got "
    end
    
    def to_s
      "MATCH #{str.inspect}"
    end
    
    def run(vm)
      source = vm.source
      error_pos = source.pos
      s = source.read(str.bytesize)

      if s.size != str.size
        source.pos = error_pos
        vm.set_error source.error("Premature end of input")
      else
        if s == str
          vm.push(s)
        else
          source.pos = error_pos
          vm.set_error source.error([@mismatch_error_prefix, s])
        end
      end
    end
  end

  Re = Struct.new(:re, :size) do
    def initialize(re, size)
      super
      @failure = "Failed to match #{re.inspect[1..-2]}"
    end
    
    def to_s
      "RE    #{re.inspect}, #{size}"
    end
    
    def run(vm)
      source = vm.source
      
      error_pos = source.pos
      s = source.read(size)
      
      if s.size != size
        source.pos = error_pos
        vm.set_error source.error("Premature end of input")
        return
      end
      
      if !s.match(re)
        source.pos = error_pos
        vm.set_error source.error(@failure)
        return
      end
      
      vm.push s
    end
  end
  
  SetupRepeat = Struct.new(:tag) do
    def run(vm)
      vm.push vm.source.pos
      vm.push 0       # occurrences
      vm.push [tag]   # will collect results
    end
    
    def to_s
      "STPRE #{tag.inspect}"
    end
  end
  
  # Repeat matching with a minimum of min and a maximum of max times. 
  # 
  Repeat = Struct.new(:min, :max, :adr, :parslet) do
    def initialize(*args)
      super
      
      @minrep_error = ["Expected at least #{min} of ", parslet]
    end
    def to_s
      "RPEAT #{min || 'n/a'}, #{max || 'n/a'}, #{adr}, #{parslet}"
    end
    def run(vm)
      source = vm.source
      start_position = source.pos
      
      unless vm.success?
        pos, occurrences, accumulator = vm.pop(3)
        source.pos = pos

        # We've encountered an error. Are we still below the minimum number of
        # matches?
        if occurrences < min
          error = source.error(@minrep_error, pos)
          error.children << vm.error
          vm.set_error error
          return
        end
        
        # assert: occurrences >= min
        
        # We've matched the minimum number required, so this is a success: 
        vm.clear_error
        vm.push accumulator
        return
      end

      # assert: vm.success?
      
      result = vm.pop
      pos, occurrences, accumulator = vm.pop(3)

      accumulator << result
      occurrences += 1

      # All went well but we have reached our maximum?
      if max && occurrences >= max
        # We're done! Push the result.
        vm.push accumulator
        return
      end

      # No maximum was set or it was not reached. Continue matching.
      vm.push vm.source.pos
      vm.push occurrences
      vm.push accumulator
      vm.jump adr
    end
  end
  
  # Checks if a sequence must be aborted early because of a parse failure. 
  # Cleans up the stack and jumps after the sequence, having set error. 
  #
  CheckSequence = Struct.new(:cleanup_items, :adr, :error) do
    def run(vm)
      unless vm.success?
        vm.pop(cleanup_items)

        cause = vm.source.error(error)
        cause.children << vm.error
        vm.set_error cause
        vm.jump(adr)
      end
    end
    def to_s
      "CHKSQ #{cleanup_items}, #{adr}, #{error[0,50] + "..."}"
    end
  end
  
  # Packs size stack elements into an array that is prefixed with the
  # :sequence tag. This will later be converted by #flatten
  #
  PackSequence = Struct.new(:size) do
    def run(vm)
      source = vm.source
            
      fail "Sequence runs into PackSequence with error flag set!" \
        unless vm.success?

      elts = vm.pop(size)
      vm.push [:sequence, *elts]
    end
    def to_s
      "PACK  #{size}"
    end
  end
  
  # Enters a new stack frame that can be discarded with vm.discard_frame. This
  # helps in situations where you need to pop a state that you don't know the
  # size of. 
  #
  EnterFrame = Class.new do
    def run(vm)
      vm.enter_frame
    end
    def to_s
      "ENTER"
    end
  end
  
  # Fails at this point with the given error message. Size indicates how many
  # different alternatives should have generated an error message on the
  # stack.
  #
  Fail = Struct.new(:message, :size) do
    def run(vm)
      children = vm.pop(size)
      error = vm.source.error(message)
      error.children.replace(children)
      
      # Clean up the stack frames:
      vm.discard_frame
      
      vm.set_error error
    end
    def to_s
      "FAIL  #{message}, #{size}"
    end
  end
  
  # If the vm.success? is true, branches to the given address. 
  #
  BranchOnSuccess = Struct.new(:adr, :pos_ptr) do
    def run(vm)
      source = vm.source
      if vm.success?
        # Stack will look like this: 
        #  (n*) previous failures
        #  successful match
        # So we pop the match, discard the failures and push the success
        # again. This way, it looks like a success should look. 
        value = vm.pop
        vm.discard_frame
        vm.push value

        vm.jump(adr)
      else
        # Otherwise, clear the error and try the alternative that comes
        # right here in the byte code.
        
        # We need to reset the source.pos to what it was before starting on
        # one of several alternatives: 
        source.pos = vm.value_at(pos_ptr)

        # Push the error as if it were a value. If all branches fail, this can
        # be used to create a complete error trace. If not, VM#discard_frame
        # will take care of those.
        vm.push vm.error
        
        vm.clear_error
      end
    end
    def to_s
      "BRSUC #{adr}, #{pos_ptr}"
    end
  end

  # Boxes a value inside a name tag.
  #
  # Consumes: parslet result
  # Pushes: boxed result
  #
  Box = Struct.new(:name) do
    def run(vm)
      if vm.success?
        result = vm.pop
        vm.push(name => result)
      end
    end
    def to_s
      "BOX   #{name.inspect}"
    end
  end

  # Pushes the current source pos to the stack.
  #
  # Consumes: Nothing
  # Pushes: the current source.pos
  #
  PushPos = Class.new do
    def run(vm)
      source = vm.source 
      vm.push source.pos
    end
    def to_s
      "PSHPS"
    end
  end

  # Assumes that the stack contains the result of a parslet and above it 
  # the source position from before parsing that parslet (as per PushPos).
  # Will remove both and leave the vm in a state that indicates the result 
  # of a lookahead, stack will be nil (no capture) and the error flag will 
  # be set. 
  #
  # Consumes: VM state, source.pos
  # Pushes: VM.state
  # Effects: resets source.pos
  #
  CheckAndReset = Struct.new(:positive, :parslet) do
    def run(vm)
      source = vm.source
      
      vm.pop if vm.success?

      # Retrieve the parse position from before attempting to match the
      # parslet.
      start_pos = vm.pop
      source.pos = start_pos
      
      if positive && vm.success? || !positive && !vm.success?
        vm.clear_error
        vm.push nil
      else
        error_msg = positive ? 
          ["Input should start with ", parslet] :
          ["Input should not start with ", parslet]
        vm.set_error source.error(error_msg, start_pos)
      end
    end
    def to_s
      "CHKRS #{positive ? ':&' : ':!'}, #{parslet.inspect}"
    end
  end
  
  # Compiles the block or 'calls' the subroutine that was compiled earlier.
  #
  CallBlock = Struct.new(:block) do
    def run(vm)
      vm.call(block.address)
    end
    def to_s
      "LCALL #{block.address} (was atom<#{block.atom}>)"
    end
  end
  Return = Class.new do
    def run(vm)
      vm.call_ret
    end
    def to_s
      "RETRN"
    end
  end
  Stop = Class.new do
    def run(vm)
      vm.stop
    end
    def to_s
      "STPVM"
    end
  end

  # Caching
  CheckCache = Struct.new(:skip_adr) do
    def run(vm)
      return if vm.access_cache(skip_adr)
      
      vm.push vm.source.pos
    end
    def to_s
      "RETCA #{skip_adr}"
    end
  end
  StoreResult = Struct.new(:adr) do
    def run(vm)
      vm.store_cache(adr)
    end
    def to_s
      "STOCA #{adr}"
    end
  end
end