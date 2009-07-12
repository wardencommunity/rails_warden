module RailsWarden
  class Manager
    
    def self.new(app, opts = {}, &block)
      # Get the failure application
      opts[:failure_app] = opts[:failure_app].to_s.classify.constantize if opts[:failure_app]
      opts[:default_strategies] = [opts[:defaults]].flatten if opts[:defaults]
      
      # Set the default user
      if user = opts.delete(:default_user)
        RailsWarden.default_user_class = user.to_s.classify.constantize
      end
      
      # Set the unauthenticated action if it's set
      if ua = opts.delete(:unauthenticated_action)
        RailsWarden.unauthenticated_action = ua
      end
      
      # Rails needs the action to be passed in with the params
      Warden::Manager.before_failure do |env, opts|
        if request = env["action_controller.rescue.request"]
          request.params["action"] = RailsWarden.unauthenticated_action
        end
      end
      
      Warden::Manager.new(app, opts, &block)
    end
    
  end
end