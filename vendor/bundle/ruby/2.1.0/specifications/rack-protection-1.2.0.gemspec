# -*- encoding: utf-8 -*-
# stub: rack-protection 1.2.0 ruby lib

Gem::Specification.new do |s|
  s.name = "rack-protection".freeze
  s.version = "1.2.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Konstantin Haase".freeze, "Akzhan Abdulin".freeze, "Corey Ward".freeze, "David Kellum".freeze, "Fojas".freeze, "Martin Mauch".freeze]
  s.date = "2011-12-30"
  s.description = "You should use protection!".freeze
  s.email = ["konstantin.mailinglists@googlemail.com".freeze, "akzhan.abdulin@gmail.com".freeze, "coreyward@me.com".freeze, "dek-oss@gravitext.com".freeze, "developer@fojasaur.us".freeze, "martin.mauch@gmail.com".freeze]
  s.homepage = "http://github.com/rkh/rack-protection".freeze
  s.rubygems_version = "2.6.3".freeze
  s.summary = "You should use protection!".freeze

  s.installed_by_version = "2.6.3" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<rack>.freeze, [">= 0"])
      s.add_development_dependency(%q<rack-test>.freeze, [">= 0"])
      s.add_development_dependency(%q<rspec>.freeze, ["~> 2.0"])
    else
      s.add_dependency(%q<rack>.freeze, [">= 0"])
      s.add_dependency(%q<rack-test>.freeze, [">= 0"])
      s.add_dependency(%q<rspec>.freeze, ["~> 2.0"])
    end
  else
    s.add_dependency(%q<rack>.freeze, [">= 0"])
    s.add_dependency(%q<rack-test>.freeze, [">= 0"])
    s.add_dependency(%q<rspec>.freeze, ["~> 2.0"])
  end
end
