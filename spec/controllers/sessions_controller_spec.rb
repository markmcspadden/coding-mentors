require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe SessionsController do

  #Delete this example and add some real ones
  it "should use SessionsController" do
    controller.should be_an_instance_of(SessionsController)
  end
  
  describe "POST signup" do
    before(:each) do
      @result = mock("result")
      @identity_url = "http://markmcspadden.blogspot.com"
    end
    
    def do_post
      post :signup, :openid_identifier => @identity_url, :user => {:email => "mark@mark.com", :name => "Mark"}
    end
    
    describe "successful open id authentication" do
      before(:each) do
        @result.stub!(:successful?).and_return(true)
        controller.stub!(:authenticate_with_open_id).and_yield(@result, @identity_url, nil)
        
        @user = mock_model(User, :save => true)
      end
      
      it "should create a new user " do
        User.should_receive(:new).and_return(@user)
        do_post
      end
    end # successful open id authentication
    

  end

end
