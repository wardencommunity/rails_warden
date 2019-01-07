require 'rails_warden/compat'

module RailsWarden
  class Engine < ::Rails::Engine
    paths.add 'lib', eager_load: true
  end
end