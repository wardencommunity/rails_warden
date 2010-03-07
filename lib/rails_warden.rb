# encoding: utf-8
require 'warden'
require 'active_support'

$:.unshift File.expand_path(File.dirname(__FILE__))
require "rails_warden/manager"
require "rails_warden/rails_settings"
require "rails_warden/controller_mixin"

module Warden::Mixins::Common
  # Gets the rails request object by default if it's available
  def request
    return @request if @request
    if defined?(ActionDispatch::Request)
      @request = ActionDispatch::Request.new(env)
    elsif env['action_controller.rescue.request']
      @request = env['action_controller.rescue.request']
    else
      Rack::Request.new(env)
    end
  end

  def raw_session
    request.session
  end

  def reset_session!
    raw_session.inspect # why do I have to inspect it to get it to clear?
    raw_session.clear
  end
end

Warden::Manager.before_failure do |env, opts|
  action = RailsWarden.unauthenticated_action || "unauthenticated"
  if Rails.respond_to?(:version) && Rails.version >= "3"
    env['action_dispatch.request.path_parameters'][:action] = action
  else
    env['warden'].request.params['action'] = action
  end
end

# Rails needs the action to be passed in with the params
Warden::Manager.before_failure do |env, opts|
  env['warden'].request.params["action"] = RailsWarden.unauthenticated_action
end


if !defined?(Rails::Railtie)
  Rails.configuration.after_initialize do
    class ActionController::Base
      include RailsWarden::Mixins::HelperMethods
      include RailsWarden::Mixins::ControllerOnlyMethods
    end

    module ApplicationHelper
      include RailsWarden::Mixins::HelperMethods
    end
  end
else
  class RailsWarden::Railtie < Rails::Railtie
    initializer :warden do
      ActionController::Base.class_eval do
        include RailsWarden::Mixins::HelperMethods
        include RailsWarden::Mixins::ControllerOnlyMethods
      end

      module ApplicationHelper
        include RailsWarden::Mixins::HelperMethods
      end
    end
  end
end

class Warden::SessionSerializer
  def serialize(user)
    [user.class, user.id]
  end

  def deserialize(key)
    klass, id = key
    klass = case klass
            when Class
              klass
            when String, Symbol
              klass.to_s.classify.constantize
            end
    klass.find(id)
  end
end
