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
    expect(r).to be_an_instance_of(Warden::Manager)
  end

  it "should set the failure application to FooFailure" do
    r = RailsWarden::Manager.new(@app, :failure_app => "foo_failure", :defaults => :password)
    expect(r.config.failure_app).to eq(FooFailure)
  end

  it "should set the default user to FooUser if specified" do
    r = RailsWarden::Manager.new(@app,  :failure_app  => "foo_failure",
                                        :defaults     => :password,
                                        :default_user => "foo_user")
    expect(RailsWarden.default_user_class).to eq(FooUser)
  end

  it "should set the default user to User if there is none specified" do
    r = RailsWarden::Manager.new(@app,  :failure_app  => "foo_failure",
                                        :defaults     => :password)
    expect(RailsWarden.default_user_class).to eq(User)
  end

  it "should set the failure action when specified" do
    r = RailsWarden::Manager.new(@app,  :failure_app  => "foo_failure",
                                        :defaults     => :password,
                                        :unauthenticated_action => :bad_login
                                        )
    expect(RailsWarden.unauthenticated_action).to eq("bad_login")
  end

  it "should set the failure action to unauthenticated when not specified" do
    r = RailsWarden::Manager.new(@app,  :failure_app  => "foo_failure",
                                        :defaults     => :password
                                        )
    expect(RailsWarden.unauthenticated_action).to eq("unauthenticated")
  end

  it "should not add a before_failure callback each time it is created" do
    original_number_of_callbacks = Warden::Manager._before_failure.size

    RailsWarden::Manager.new(@app,  :failure_app  => "foo_failure",
                                    :defaults     => :password)

    expect(Warden::Manager._before_failure.size).to eq(original_number_of_callbacks)
  end

end
