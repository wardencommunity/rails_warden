# encoding: utf-8
require 'warden'

require "rails_warden/version"
require "rails_warden/engine"

require "rails_warden/authentication"
require "rails_warden/manager"
require "rails_warden/rails_settings"

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

  def response
    return @response if @response
    if defined?(ActionDispatch::Response)
      @response  = ActionDispatch::Response.new
    elsif env['action_controller.rescue.response']
      @response = env['action_controller.rescue.response']
    else
      Rack::Response.new(env)
    end
  end

  def cookies
    unless defined?('ActionController::Cookies')
      puts 'cookies was not defined'
      return
    end
    @cookies ||= begin
      # Duck typing...
      controller = Struct.new(:request, :response) do
        def self.helper_method(*args); end
      end
      controller.send(:include, ActionController::Cookies)
      controller.new(self.request, self.response).send(:cookies)
    end
  end

  def logger
    unless defined?('Rails')
      puts 'logger not defined'
      return
    end
    Rails.logger
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
  opts ||= {}
  action = opts[:action] || RailsWarden.unauthenticated_action || "unauthenticated"
  if Rails.respond_to?(:version) && Rails.version >= "3"
    env['action_dispatch.request.path_parameters'][:action] = action
  else
    env['warden'].request.params['action'] = action
  end
end

class Warden::SessionSerializer
  def serialize(user)
    [user.class.name, user.id]
  end

  def deserialize(key)
    klass, id = key
    klass = case klass
            when Class
              klass
            when String, Symbol
              klass.to_s.classify.constantize
            end
    klass.find_by(id: id)
  end
end
