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
    
    it "should be successful" do
      do_get
      response.should be_success
    end
  end
end
