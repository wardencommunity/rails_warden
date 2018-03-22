# encoding: utf-8
module RailsWarden
  module Authentication
    extend ActiveSupport::Concern

    included do
      helper_method :authenticated?, :user
    end

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

    # Access the currently logged in user
    # :api: public
    def user(*args)
      warden.user(*args)
    end

    def login!(user)
      warden.set_user user
    end

    # Logout the current user
    # :api: public
    def logout(*args)
      warden.logout(*args)
      warden.clear_strategies_cache!
    end

    # Proxy to the authenticate method on warden
    # :api: public
    def authenticate(*args)
      warden.authenticate(*args)
    end

    # Proxy to the authenticate method on warden
    # :api: public
    def authenticate!(*args)
      defaults = {action: RailsWarden.unauthenticated_action}
      if args.last.is_a? Hash
        args[-1] = defaults.merge(args.last)
      else
        args << defaults
      end
      warden.authenticate!(*args)
    end
  end
end
