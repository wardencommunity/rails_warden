# encoding: utf-8
module RailsWarden
  module Mixins
    module HelperMethods
      # The main accessor for the warden proxy instance
      # :api: public
      def warden
        request.env['warden']
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

      def user=(user)
        warden.set_user user
      end
      alias_method :current_user=, :user=
    end # Helper Methods

    module ControllerOnlyMethods
      # Logout the current user
      # :api: public
      def logout(*args)
        warden.raw_session.inspect  # Without this inspect here.  The session does not clear :|
        warden.logout(*args)
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

    end
  end
end
