# -*- encoding: utf-8 -*-
# stub: gli 1.6.0 ruby lib lib

Gem::Specification.new do |s|
  s.name = "gli".freeze
  s.version = "1.6.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze, "lib".freeze]
  s.authors = ["David Copeland".freeze]
  s.date = "2012-04-09"
  s.description = "An application and API for describing command line interfaces that can be used to quickly create a shell for executing command-line tasks.  The command line user interface is similar to Gits, in that it takes global options, a command, command-specific options, and arguments".freeze
  s.email = "davidcopeland@naildrivin5.com".freeze
  s.executables = ["gli".freeze]
  s.extra_rdoc_files = ["README.rdoc".freeze, "gli.rdoc".freeze]
  s.files = ["README.rdoc".freeze, "bin/gli".freeze, "gli.rdoc".freeze]
  s.homepage = "http://davetron5000.github.com/gli".freeze
  s.rdoc_options = ["--title".freeze, "Git Like Interface".freeze, "--main".freeze, "README.rdoc".freeze]
  s.rubyforge_project = "gli".freeze
  s.rubygems_version = "2.6.3".freeze
  s.summary = "A Git Like Interface for building command line apps".freeze

  s.installed_by_version = "2.6.3" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<rake>.freeze, ["~> 0.9.2.2"])
      s.add_development_dependency(%q<rdoc>.freeze, ["~> 3.11"])
      s.add_development_dependency(%q<reek>.freeze, ["~> 1.2.0"])
      s.add_development_dependency(%q<roodi>.freeze, ["~> 2.1.0"])
      s.add_development_dependency(%q<grancher>.freeze, ["~> 0.1.5"])
      s.add_development_dependency(%q<rainbow>.freeze, ["~> 1.1.1"])
      s.add_development_dependency(%q<aruba>.freeze, ["~> 0.4.7"])
    else
      s.add_dependency(%q<rake>.freeze, ["~> 0.9.2.2"])
      s.add_dependency(%q<rdoc>.freeze, ["~> 3.11"])
      s.add_dependency(%q<reek>.freeze, ["~> 1.2.0"])
      s.add_dependency(%q<roodi>.freeze, ["~> 2.1.0"])
      s.add_dependency(%q<grancher>.freeze, ["~> 0.1.5"])
      s.add_dependency(%q<rainbow>.freeze, ["~> 1.1.1"])
      s.add_dependency(%q<aruba>.freeze, ["~> 0.4.7"])
    end
  else
    s.add_dependency(%q<rake>.freeze, ["~> 0.9.2.2"])
    s.add_dependency(%q<rdoc>.freeze, ["~> 3.11"])
    s.add_dependency(%q<reek>.freeze, ["~> 1.2.0"])
    s.add_dependency(%q<roodi>.freeze, ["~> 2.1.0"])
    s.add_dependency(%q<grancher>.freeze, ["~> 0.1.5"])
    s.add_dependency(%q<rainbow>.freeze, ["~> 1.1.1"])
    s.add_dependency(%q<aruba>.freeze, ["~> 0.4.7"])
  end
end
