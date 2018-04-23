require File.dirname(__FILE__) + '/spec_helper'
require 'ostruct'


describe "rails_warden controller mixin" do
  
  before(:each) do
    @app = lambda{|e| [200, {"Content-Type" => "text/plain"}, ["resonse"]]}
    class FooFailure
    end
    
    class User
    end
    
    class MockController 
      include RailsWarden::Mixins::HelperMethods
      include RailsWarden::Mixins::ControllerOnlyMethods
      attr_accessor :env
      def request
        self
      end
    end
    
    RailsWarden.default_user_class = nil
    RailsWarden.unauthenticated_action = nil
    
    @controller = MockController.new
    @mock_warden = OpenStruct.new
    @controller.env = {"warden" => @mock_warden }
  end
  
  it "should setup the spec" do
    expect(@controller.warden).not_to be_nil
  end
  
  it "should provide access to the warden instance" do
    expect(@controller.warden).to eq(@controller.env["warden"])
  end
  
  it "should run authenticate on warden" do
    expect(@mock_warden).to receive(:authenticate).and_return(true)
    @controller.authenticate
  end
  
  it "should run authenticate! on warden" do
    expect(@mock_warden).to receive(:authenticate!).and_return(true)
    @controller.authenticate!
  end
  
  it "should run authenticate? on warden" do
    expect(@mock_warden).to receive(:authenticated?).and_return(true)
    @controller.authenticated?
  end
  
  it "should proxy logged_in? to authenticated" do
    expect(@mock_warden).to receive(:authenticated?).and_return(true)
    @controller.logged_in?
  end
  
  it "should run user on warden" do
    expect(@mock_warden).to receive(:user).and_return(true)
    @controller.user
  end
  
  it "should run current_user on warden" do
    expect(@mock_warden).to receive(:user).and_return(true)
    @controller.current_user
  end

  it "should set the user on warden" do
    expect(@mock_warden).to receive(:set_user).and_return(true)
    @controller.user = User.new
  end
  
  it "should proxy logout to warden" do
    expect(@mock_warden).to receive(:logout).and_return(true)
    @controller.logout
  end
end
