Gem::Specification.new do |s|
  s.name = "rails_warden"
  s.version = "1.0.0"
  s.authors = ["Daniel Neighman", "Justin Smestad", "Whitney Smestad"]
  s.summary = "A gem that provides authentication Rails helpers when using Warden for authentication"
  s.description = "A gem that provides authentication Rails helpers when using Warden for authentication"
  s.email = "has.sox@gmail.com"
  s.homepage = "https://github.com/hassox/rails_warden"

  s.extra_rdoc_files = [
    "LICENSE",
    "README.md"
  ]

  s.files = Dir["lib/**/*"]
  s.add_dependency "warden", ">= 1.2.0"
end

