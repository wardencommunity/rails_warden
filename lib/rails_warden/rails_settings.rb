# encoding: utf-8
module RailsWarden

  # Set the default user class for the application
  # :api: public
  def self.default_user_class=(klass)
    @default_user_class = klass
  end

  # Accessor for the default user class for the application
  # :api: public
  def self.default_user_class
    @default_user_class ||= User
  end

  # Get the action called when there is an unauthenticated failure
  # This is usually an action on a controller
  # The action is called on the failure application.  This would normally be
  # A rails controller
  #
  # Example
  #  RailsWarden::Manager.new(@app,  :failure_app  => "login_controller",
  #                                   :defaults     => :password,
  #                                   :unauthenticated_action => :bad_login
  #                           )
  #
  # The unauthenticated_action is :bad_login
  # The bad_login action will be called on the LoginController
  # :api: public
  def self.unauthenticated_action=(action)
    action = action.to_s if action
    @unauthenticated_action = action
  end

  # Get the action called when there is an unauthenticated failure
  # This is usually an action on a controller
  # The action is called on the failure application.  This would normally be
  # A rails controller
  #
  # Example
  #  RailsWarden::Manager.new(@app,  :failure_app  => "login_controller",
  #                                   :defaults     => :password,
  #                                   :unauthenticated_action => :bad_login
  #                           )
  #
  # The unauthenticated_action is :bad_login
  # The bad_login action will be called on the LoginController
  # :api: public
  def self.unauthenticated_action
    @unauthenticated_action ||= "unauthenticated"
  end
end
