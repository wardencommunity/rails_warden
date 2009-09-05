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
    if env['action_controller.rescue.request']
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
  env['warden'].request.params['action'] = RailsWarden.unauthenticated_action || "unauthenticated"
end

if defined?(Rails)
  Rails.configuration.after_initialize do
    class ActionController::Base
      include RailsWarden::Mixins::HelperMethods
      include RailsWarden::Mixins::ControllerOnlyMethods
    end

    module ApplicationHelper
      include RailsWarden::Mixins::HelperMethods
    end
  end
end

# Session Serialization in.  This block determines how the user will
# be stored in the session.  If you're using a complex object like an
# ActiveRecord model, it is not a good idea to store the complete object.
# An ID is sufficient
Warden::Manager.serialize_into_session{ |user| [user.class, user.id] }

# Session Serialization out.  This block gets the user out of the session.
# It should be the reverse of serializing the object into the session
Warden::Manager.serialize_from_session do |klass, id|
  klass = case klass
  when Class
    klass
  when String, Symbol
    klass.to_s.classify.constantize
  end
  klass.find(id)
end
