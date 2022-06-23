# frozen_string_literal: true

require 'rails_warden/compat'

module RailsWarden
  class Engine < ::Rails::Engine
    config.autoload_paths << File.expand_path("../..", __dir__)
  end
end
