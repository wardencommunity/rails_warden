# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "rails_warden/version"

Gem::Specification.new do |spec|
  spec.name = "rails_warden"
  spec.version = RailsWarden::VERSION
  spec.authors = ["Daniel Neighman", "Justin Smestad", "Whitney Smestad"]
  spec.summary = "A gem that provides authentication Rails helpers when using Warden for authentication"
  spec.description = "A gem that provides authentication Rails helpers when using Warden for authentication"
  spec.email = "haspec.sox@gmail.com"
  spec.homepage = "https://github.com/hassox/rails_warden"

  spec.files = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end

  spec.require_paths = ["lib"]

  spec.add_dependency "warden", ">= 1.2.0"
  spec.add_dependency "activesupport"

  spec.add_development_dependency "bundler"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "rails"
end
