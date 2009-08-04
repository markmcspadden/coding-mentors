require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe PagesController do

  #Delete these examples and add some real ones
  it "should use PagesController" do
    controller.should be_an_instance_of(PagesController)
  end


  describe "GET home" do
    before(:each) do
      @users = []
      User.stub!(:random).and_return(@users)
      
      @skills = []
      Skill.stub!(:random).and_return(@skills)
    end
    
    def do_get
      get 'home'
    end
    
    it "should get 2 random users" do      
      User.should_receive(:random).with(2)
      do_get
    end
    
    it "should assign the random users as @user" do
      do_get
      assigns[:users].should == @users
    end
    
    it "should get 2 random skills" do
      Skill.should_receive(:random).with(2)
      do_get
    end
    
    it "should assign the random skills as @skills" do
      do_get
      assigns[:skills].should == @skills
    end

    describe "flash[:notice]" do
      before(:each) do
        @user = mock_model(User)
        controller.stub!(:current_user).and_return(@user)        
      end
      
      it "should assign any mentorships needing response if there is a current user with outstanding mentorships" do      
        @m1 = mock_model(Mentorship)
        @user.should_receive(:mentorships_to_respond_to).and_return([@m1])        
        
        do_get
        flash[:notice].to_s.strip.should == "You have requests awaiting your response:<br/>\n          <a href=\"/mentorships/#{@m1.id}/respond\">Respond</a>"
      end
      it "should not assign if there are no current_user" do
        controller.stub!(:current_user).and_return(nil)
      
        do_get
        flash[:notice].should be_nil  
      end    
      it "should not assign if there are no outstanding mentorships" do
        @user.should_receive(:mentorships_to_respond_to).and_return([])
      
        do_get
        flash[:notice].should be_nil
      end
    end #flash[:notice]
    
    it "should be successful" do
      do_get
      response.should be_success
    end
  end # GET home
  
  describe "GET search" do
    before(:each) do
      @users = []
      User.stub!(:search).and_return(@users)
    end
    
    def do_get(params={})
      get 'search', params
    end
    
    it "should get some users from search param if one is present" do
      User.should_receive(:search).with("ruby")
      
      do_get(:q => "ruby")
    end
    
    it "should assign the users as @users" do
      do_get(:q => "ruby")
      assigns[:users].should == @users
    end
    
    it "should be successful" do
      do_get
      response.should be_success
    end
  end
  
  describe "GET guides" do    
    def do_get
      get 'guides'
    end
    
    it "should be successful" do
      do_get
      response.should be_success
    end
  end
  
  describe "GET about" do
    def do_get
      get 'about'
    end
    
    it "should be successful" do
      do_get
      response.should be_success
    end
  end 
  
  describe "GET error" do
    def do_get
      get 'error'
    end
    
    it "should be successful" do
      do_get
      response.should be_success
    end
  end
  
  describe "GET denied" do
    def do_get
      get 'denied'
    end
    
    it "should be successful" do
      do_get
      response.should be_success
    end
  end       
end
