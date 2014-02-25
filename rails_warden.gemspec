Gem::Specification.new do |s|
  s.name = "rails_warden"
  s.version = "0.5.7"
  s.authors = ["Daniel Neighman"]
  s.summary = "A gem that provides authenitcation via the Warden framework"
  s.description = "A gem that provides authenitcation via the Warden framework"
  s.email = "has.sox@gmail.com"
  s.homepage = "https://github.com/hassox/rails_warden"

  s.extra_rdoc_files = [
    "LICENSE",
    "README.textile",
    "TODO"
  ]

  s.files = Dir["lib/**/*"]
  s.add_dependency "warden", ">=1.0.0"
end

