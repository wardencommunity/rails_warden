# Generated by jeweler
# DO NOT EDIT THIS FILE
# Instead, edit Jeweler::Tasks in Rakefile, and run `rake gemspec`
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{rails_warden}
  s.version = "0.2.4"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Daniel Neighman"]
  s.date = %q{2009-09-09}
  s.description = %q{A gem that provides authenitcation via the Warden framework}
  s.email = %q{has.sox@gmail.com}
  s.extra_rdoc_files = [
    "LICENSE",
     "README.textile",
     "TODO"
  ]
  s.files = [
    ".gitignore",
     "LICENSE",
     "README.textile",
     "Rakefile",
     "TODO",
     "VERSION",
     "lib/rails_warden.rb",
     "lib/rails_warden/controller_mixin.rb",
     "lib/rails_warden/manager.rb",
     "lib/rails_warden/rails_settings.rb",
     "rails_warden.gemspec",
     "script/destroy",
     "script/generate",
     "spec/controller_mixin_spec.rb",
     "spec/rails_warden_spec.rb",
     "spec/spec_helper.rb"
  ]
  s.homepage = %q{http://github.com/hassox/rails_warden}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{warden}
  s.rubygems_version = %q{1.3.5}
  s.summary = %q{A gem that provides authenitcation via the Warden framework}
  s.test_files = [
    "spec/controller_mixin_spec.rb",
     "spec/rails_warden_spec.rb",
     "spec/spec_helper.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
