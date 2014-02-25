require 'bundler/setup'
require 'bundler/gem_tasks'
require 'rspec/core'
require 'rspec/core/rake_task'
require 'bump/tasks'

task :default => :spec

desc "Run specs"
RSpec::Core::RakeTask.new(:spec)

desc "Run tests against all other versions of Rails (!run task without 'bundle exec'!)"
task :all do
  versions = %w[~>2 ~>3.0.0 ~>3.1.0]
  versions.each do |version|
    sh "export RAILS_VERSION='#{version}' && (bundle check || bundle update) && bundle exec rake"
  end

  sh "git co Gemfile.lock"
end
