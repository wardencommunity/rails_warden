module RailsWarden
  module ControllerMixin
    
    def self.included(base)
      base.send(:include, InstanceMethods)
    end
    
    module InstanceMethods
      # The main accessor for the warden proxy instance
      # :api: public
      def warden
        request.env['warden']
      end
      
      # Proxy to the authenticate method on warden
      # :api: public
      def authenticate(*args)
        warden.authenticate(*args)
      end
      
      # Proxy to the authenticate method on warden
      # :api: public
      def authenticate!(*args)
        warden.authenticate!(*args)
      end
      
      # Proxy to the authenticated? method on warden
      # :api: public
      def authenticated?(*args)
        warden.authenticated?(*args)
      end
      alias_method :logged_in?, :authenticated?
      
      # Access the currently logged in user
      # :api: public
      def user(*args)
        warden.user(*args)
      end
      alias_method :current_user, :user
      
      # Logout the current user
      # :api: public
      def logout(*args)
        warden.logout(*args)
      end
    end
  end
end