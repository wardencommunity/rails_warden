# frozen_string_literal: true

require 'spec_helper'

RSpec.describe "rails_warden controller mixin" do
  let(:ret) { Object.new }

  before(:each) do
    @app = lambda {|e| [200, {"Content-Type" => "text/plain"}, ["resonse"]]}

    RailsWarden.default_user_class = nil
    RailsWarden.unauthenticated_action = nil

    @controller = MockController.new
    @mock_warden = OpenStruct.new
    @controller.env = {"warden" => @mock_warden }
  end

  it "should setup the spec" do
    expect(@controller.warden).to be_a(OpenStruct)
  end

  it "should provide access to the warden instance" do
    expect(@controller.warden).to eql(@controller.env["warden"])
  end

  it "should run authenticate on warden" do
    expect(@mock_warden).to receive(:authenticate).with(no_args).and_return(ret)
    expect(@controller.authenticate).to be(ret)
  end

  it "should pass options to authenticate on warden" do
    expect(@mock_warden).to receive(:authenticate).with({scope: :foo, store: false}).and_return(ret)
    expect(@controller.authenticate(scope: :foo, store: false)).to be(ret)
  end

  it "should run authenticate! on warden, with a default :action option" do
    expect(@mock_warden).to receive(:authenticate!).with({action: RailsWarden.unauthenticated_action}).and_return(ret)
    expect(@controller.authenticate!).to be(ret)
  end

  it "should pass options to authenticate! on warden" do
    expect(@mock_warden).to receive(:authenticate!).with({scope: :foo, store: false, action: :bar}).and_return(ret)
    expect(@controller.authenticate!(scope: :foo, store: false, action: :bar)).to be(ret)
  end

  it "should run authenticate? on warden" do
    expect(@mock_warden).to receive(:authenticated?).with(no_args).and_return(ret)
    expect(@controller.authenticated?).to be(ret)
  end

  it "should pass options to authenticate? on warden" do
    expect(@mock_warden).to receive(:authenticated?).with({scope: :foo, run_callbacks: false}).and_return(ret)
    expect(@controller.authenticated?(scope: :foo, run_callbacks: false)).to be(ret)
  end

  it "should run user on warden" do
    expect(@mock_warden).to receive(:user).with(no_args).and_return(ret)
    expect(@controller.user).to be(ret)
  end

  it "should pass arguments to user on warden" do
    expect(@mock_warden).to receive(:user).with(:foo).and_return(ret)
    expect(@controller.user(:foo)).to be(ret)
  end

  it "should pass options to user on warden" do
    expect(@mock_warden).to receive(:user).with({scope: :foo}).and_return(ret)
    expect(@controller.user(scope: :foo)).to be(ret)
  end

  it "should set the user on warden" do
    user = User.new
    expect(@mock_warden).to receive(:set_user).with(user, {}).and_return(ret)
    expect(@controller.login!(user)).to be(ret)
  end

  it "should set the user on warden with options" do
    user = User.new
    expect(@mock_warden).to receive(:set_user).with(user, {scope: :foo, event: :set_user, store: false}).and_return(ret)
    expect(@controller.login!(user, scope: :foo, event: :set_user, store: false)).to be(ret)
  end

  it "should proxy logout! to warden" do
    expect(@mock_warden).to receive(:logout).with(no_args).and_return(true)
    expect(@mock_warden).to receive(:clear_strategies_cache!).with(no_args).and_return(ret)
    expect(@controller.logout!).to be(ret)
  end

  it "should proxy logout! with a scope to warden" do
    expect(@mock_warden).to receive(:logout).with(:foo).and_return(true)
    expect(@mock_warden).to receive(:clear_strategies_cache!).with(scope: :foo).and_return(ret)
    expect(@controller.logout!(scope: :foo)).to be(ret)
  end
end
