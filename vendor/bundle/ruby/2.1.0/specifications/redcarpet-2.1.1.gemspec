# -*- encoding: utf-8 -*-
# stub: redcarpet 2.1.1 ruby lib
# stub: ext/redcarpet/extconf.rb

Gem::Specification.new do |s|
  s.name = "redcarpet".freeze
  s.version = "2.1.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Natacha Port\u{c3}\u{a9}".freeze, "Vicent Mart\u{c3}\u{ad}".freeze]
  s.date = "2011-09-14"
  s.description = "A fast, safe and extensible Markdown to (X)HTML parser".freeze
  s.email = "vicent@github.com".freeze
  s.executables = ["redcarpet".freeze]
  s.extensions = ["ext/redcarpet/extconf.rb".freeze]
  s.extra_rdoc_files = ["COPYING".freeze]
  s.files = ["COPYING".freeze, "bin/redcarpet".freeze, "ext/redcarpet/extconf.rb".freeze]
  s.homepage = "http://github.com/tanoku/redcarpet".freeze
  s.rubygems_version = "2.6.3".freeze
  s.summary = "Markdown that smells nice".freeze

  s.installed_by_version = "2.6.3" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<rake-compiler>.freeze, [">= 0"])
    else
      s.add_dependency(%q<rake-compiler>.freeze, [">= 0"])
    end
  else
    s.add_dependency(%q<rake-compiler>.freeze, [">= 0"])
  end
end
