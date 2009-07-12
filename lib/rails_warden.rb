here = File.dirname(__FILE__)

require 'rubygems'
require 'warden'
require 'active_support'
require "#{here}/rails_warden/manager"
require "#{here}/rails_warden/rails_settings"
require "#{here}/rails_warden/controller_mixin"

Warden::Manager.before_failure do |env, opts|
  request = env["action_controller.rescue.request"]
  request.params["action"] = RailsWarden.unauthenticated_action || "unauthenticated"
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