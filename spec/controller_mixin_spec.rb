require File.dirname(__FILE__) + '/spec_helper'


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
    @controller.warden.should_not be_nil
  end
  
  it "should provide access to the warden instance" do
    @controller.warden.should == @controller.env["warden"]
  end
  
  it "should run authenticate on warden" do
    @mock_warden.should_receive(:authenticate).and_return(true)
    @controller.authenticate
  end
  
  it "should run authenticate! on warden" do
    @mock_warden.should_receive(:authenticate!).and_return(true)
    @controller.authenticate!
  end
  
  it "should run authenticate? on warden" do
    @mock_warden.should_receive(:authenticated?).and_return(true)
    @controller.authenticated?
  end
  
  it "should proxy logged_in? to authenticated" do
    @mock_warden.should_receive(:authenticated?).and_return(true)
    @controller.logged_in?
  end
  
  it "should run user on warden" do
    @mock_warden.should_receive(:user).and_return(true)
    @controller.user
  end
  
  it "should run current_user on warden" do
    @mock_warden.should_receive(:user).and_return(true)
    @controller.current_user
  end
  
  it "should proxy logout to warden" do
    @mock_warden.should_receive(:logout).and_return(true)
    @controller.logout
  end
end