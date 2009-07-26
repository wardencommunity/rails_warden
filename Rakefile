require 'rubygems'
require 'date'
require 'spec/rake/spectask'

GEM = "rails_warden"
AUTHORS = ["Daniel Neighman"]
EMAIL = "has.sox@gmail.com"
HOMEPAGE = "http://github.com/hassox/rails_warden"
SUMMARY = "A gem that provides authenitcation via the Warden framework"

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name = GEM
    gem.email = EMAIL
    gem.has_rdoc = true
    gem.extra_rdoc_files = ["README.textile", "LICENSE", 'TODO']
    gem.summary = SUMMARY
    gem.description = SUMMARY
    gem.authors = AUTHORS
    gem.email = EMAIL
    gem.homepage = HOMEPAGE
    gem.rubyforge_project = "warden"
    gem.add_dependency    "warden", "> 0.2.0"
  end
rescue LoadError
  puts "Jeweler (or a dependency) not available.  Install with: sudo gem install jeweler"
end

task :default => :spec

desc "Run specs"
Spec::Rake::SpecTask.new do |t|
  t.spec_files = FileList['spec/**/*_spec.rb']
  t.spec_opts = %w(-fs --color)
end