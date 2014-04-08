# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "gli"
  s.version = "1.6.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["David Copeland"]
  s.date = "2012-04-09"
  s.description = "An application and API for describing command line interfaces that can be used to quickly create a shell for executing command-line tasks.  The command line user interface is similar to Gits, in that it takes global options, a command, command-specific options, and arguments"
  s.email = "davidcopeland@naildrivin5.com"
  s.executables = ["gli"]
  s.extra_rdoc_files = ["README.rdoc", "gli.rdoc"]
  s.files = ["bin/gli", "README.rdoc", "gli.rdoc"]
  s.homepage = "http://davetron5000.github.com/gli"
  s.rdoc_options = ["--title", "Git Like Interface", "--main", "README.rdoc"]
  s.require_paths = ["lib", "lib"]
  s.rubyforge_project = "gli"
  s.rubygems_version = "1.8.24"
  s.summary = "A Git Like Interface for building command line apps"

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<rake>, ["~> 0.9.2.2"])
      s.add_development_dependency(%q<rdoc>, ["~> 3.11"])
      s.add_development_dependency(%q<reek>, ["~> 1.2.0"])
      s.add_development_dependency(%q<roodi>, ["~> 2.1.0"])
      s.add_development_dependency(%q<grancher>, ["~> 0.1.5"])
      s.add_development_dependency(%q<rainbow>, ["~> 1.1.1"])
      s.add_development_dependency(%q<aruba>, ["~> 0.4.7"])
    else
      s.add_dependency(%q<rake>, ["~> 0.9.2.2"])
      s.add_dependency(%q<rdoc>, ["~> 3.11"])
      s.add_dependency(%q<reek>, ["~> 1.2.0"])
      s.add_dependency(%q<roodi>, ["~> 2.1.0"])
      s.add_dependency(%q<grancher>, ["~> 0.1.5"])
      s.add_dependency(%q<rainbow>, ["~> 1.1.1"])
      s.add_dependency(%q<aruba>, ["~> 0.4.7"])
    end
  else
    s.add_dependency(%q<rake>, ["~> 0.9.2.2"])
    s.add_dependency(%q<rdoc>, ["~> 3.11"])
    s.add_dependency(%q<reek>, ["~> 1.2.0"])
    s.add_dependency(%q<roodi>, ["~> 2.1.0"])
    s.add_dependency(%q<grancher>, ["~> 0.1.5"])
    s.add_dependency(%q<rainbow>, ["~> 1.1.1"])
    s.add_dependency(%q<aruba>, ["~> 0.4.7"])
  end
end
