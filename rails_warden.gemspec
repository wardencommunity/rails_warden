# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{rails_warden}
  s.version = "0.2.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Daniel Neighman"]
  s.autorequire = %q{rails_warden}
  s.date = %q{2009-07-12}
  s.description = %q{A gem that provides authenitcation via the Warden framework}
  s.email = %q{has.sox@gmail.com}
  s.extra_rdoc_files = ["README.textile", "LICENSE", "TODO"]
  s.files = ["LICENSE", "README.textile", "Rakefile", "TODO", "lib/rails_warden", "lib/rails_warden/controller_mixin.rb", "lib/rails_warden/manager.rb", "lib/rails_warden/rails_settings.rb", "lib/rails_warden.rb", "spec/controller_mixin_spec.rb", "spec/rails_warden_spec.rb", "spec/spec_helper.rb"]
  s.homepage = %q{http://github.com/hassox/rails_warden}
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.3}
  s.summary = %q{A gem that provides authenitcation via the Warden framework}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<warden>, [">= 0"])
    else
      s.add_dependency(%q<warden>, [">= 0"])
    end
  else
    s.add_dependency(%q<warden>, [">= 0"])
  end
end
