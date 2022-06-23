# frozen_string_literal: true

require 'spec_helper'

RSpec.describe "rails_warden" do

  before(:each) do
    @app = lambda { |e| Rack::Response.new("response").finish }

    RailsWarden.default_user_class = nil
    RailsWarden.unauthenticated_action = nil
  end

  it "RailsWarden::Manager.new should return an instance of Warden::Manager" do
    r = RailsWarden::Manager.new(@app, :failure_app => "foo_failure", :defaults => :password)
    expect(r).to be_an_instance_of(Warden::Manager)
  end

  it "should set the failure application to FooFailure" do
    r = RailsWarden::Manager.new(@app, :failure_app => "foo_failure", :defaults => :password)
    expect(r.config.failure_app).to eql(FooFailure)
  end

  it "should set the default user to FooUser if specified" do
    r = RailsWarden::Manager.new(@app,  :failure_app  => "foo_failure",
                                        :defaults     => :password,
                                        :default_user => "foo_user")
    expect(RailsWarden.default_user_class).to eql(FooUser)
  end

  it "should set the default user to User if there is none specified" do
    r = RailsWarden::Manager.new(@app,  :failure_app  => "foo_failure",
                                        :defaults     => :password)
    expect(RailsWarden.default_user_class).to eql(User)
  end

  it "should set the failure action when specified" do
    r = RailsWarden::Manager.new(@app,  :failure_app  => "foo_failure",
                                        :defaults     => :password,
                                        :unauthenticated_action => :bad_login
                                        )
    expect(RailsWarden.unauthenticated_action).to eql("bad_login")
  end

  it "should set the failure action to unauthenticated when not specified" do
    r = RailsWarden::Manager.new(@app,  :failure_app  => "foo_failure",
                                        :defaults     => :password
                                        )
    expect(RailsWarden.unauthenticated_action).to eql("unauthenticated")
  end

  it "should not add a before_failure callback each time it is created" do
    original_number_of_callbacks = Warden::Manager._before_failure.size

    RailsWarden::Manager.new(@app,  :failure_app  => "foo_failure",
                                    :defaults     => :password)

    expect(Warden::Manager._before_failure.size).to eql(original_number_of_callbacks)
  end

end
