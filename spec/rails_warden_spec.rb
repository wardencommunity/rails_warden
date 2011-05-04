require File.dirname(__FILE__) + '/spec_helper'

describe "rails_warden" do

  before(:each) do
    @app = lambda{|e| Rack::Resposnse.new("response").finish}
    class ::FooFailure
    end

    class ::FooUser
    end

    class ::User
    end

    RailsWarden.default_user_class = nil
    RailsWarden.unauthenticated_action = nil
  end

  it "RailsWarden::Manager.new should return an instance of Warden::Manager" do
    r = RailsWarden::Manager.new(@app, :failure_app => "foo_failure", :defaults => :password)
    r.should be_an_instance_of(Warden::Manager)
  end

  it "should set the failure application to FooFailure" do
    r = RailsWarden::Manager.new(@app, :failure_app => "foo_failure", :defaults => :password)
    r.config.failure_app.should == FooFailure
  end

  it "should set the default user to FooUser if specified" do
    r = RailsWarden::Manager.new(@app,  :failure_app  => "foo_failure",
                                        :defaults     => :password,
                                        :default_user => "foo_user")
    RailsWarden.default_user_class.should == FooUser
  end

  it "should set the default user to User if there is none specified" do
    r = RailsWarden::Manager.new(@app,  :failure_app  => "foo_failure",
                                        :defaults     => :password)
    RailsWarden.default_user_class.should == User
  end

  it "should set the failure action when specified" do
    r = RailsWarden::Manager.new(@app,  :failure_app  => "foo_failure",
                                        :defaults     => :password,
                                        :unauthenticated_action => :bad_login
                                        )
    RailsWarden.unauthenticated_action.should == "bad_login"
  end

  it "should set the failure action to unauthenticated when not specified" do
    r = RailsWarden::Manager.new(@app,  :failure_app  => "foo_failure",
                                        :defaults     => :password
                                        )
    RailsWarden.unauthenticated_action.should == "unauthenticated"
  end

  it "should not add a before_failure callback each time it is created" do
    original_number_of_callbacks = Warden::Manager._before_failure.size

    RailsWarden::Manager.new(@app,  :failure_app  => "foo_failure",
                                    :defaults     => :password)

    Warden::Manager._before_failure.size.should == original_number_of_callbacks
  end

end
