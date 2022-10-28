# -*- encoding: utf-8 -*-
# stub: rspec-instafail 1.0.0 ruby lib

Gem::Specification.new do |s|
  s.name = "rspec-instafail".freeze
  s.version = "1.0.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Michael Grosser".freeze]
  s.date = "2016-05-20"
  s.email = "michael@grosser.it".freeze
  s.homepage = "https://github.com/grosser/rspec-instafail".freeze
  s.licenses = ["MIT".freeze]
  s.rubygems_version = "3.3.24".freeze
  s.summary = "Show failing specs instantly".freeze

  s.installed_by_version = "3.3.24" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4
  end

  if s.respond_to? :add_runtime_dependency then
    s.add_runtime_dependency(%q<rspec>.freeze, [">= 0"])
  else
    s.add_dependency(%q<rspec>.freeze, [">= 0"])
  end
end
