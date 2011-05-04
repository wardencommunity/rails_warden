Gem::Specification.new do |s|
  s.name = %q{rails_warden}
  s.version = "0.5.4"
  s.authors = ["Daniel Neighman"]
  s.date = %q{2010-05-14}
  s.summary = %q{A gem that provides authenitcation via the Warden framework}
  s.description = %q{A gem that provides authenitcation via the Warden framework}
  s.email = %q{has.sox@gmail.com}
  s.homepage = %q{http://github.com/hassox/rails_warden}
  s.rubygems_version = %q{1.3.7}

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.extra_rdoc_files = [
    "LICENSE",
     "README.textile",
     "TODO"
  ]

  s.files = Dir["**/*"]
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{warden}

  s.add_dependency "warden", ">=1.0.0"
end

