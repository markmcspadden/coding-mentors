require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe MentorshipsController do

  def mock_mentorship(stubs={})
    @mock_mentorship ||= mock_model(Mentorship, stubs)
  end
  
  describe "GET index" do
    it "assigns all mentorships as @mentorships" do
      Mentorship.stub!(:find).with(:all).and_return([mock_mentorship])
      get :index
      assigns[:mentorships].should == [mock_mentorship]
    end
  end

  describe "GET show" do
    it "assigns the requested mentorship as @mentorship" do
      Mentorship.stub!(:find).with("37").and_return(mock_mentorship)
      get :show, :id => "37"
      assigns[:mentorship].should equal(mock_mentorship)
    end
  end

  describe "GET new" do
    before(:each) do
      @mentorship = mock_model(Mentorship, :mentor_id= => true, :mentee_id= => true, :sender_id= => true, :receiver_id= => true, :matched_skills => [])
      
      
      @current_user = mock_model(User, :skills => [], :user_skills => [])
      controller.stub!(:current_user).and_return(@current_user)
      
      @mentor = mock_model(User, :skills => [], :user_skills => [])
      User.stub!(:find).with("1").and_return(@mentor)
    end
    
    def do_get(params = {})
      params = {:mentor_id => 1} if params.blank?

      get :new, params
    end
    
    it "assigns a new mentorship as @mentorship" do      
      Mentorship.stub!(:new).and_return(@mentorship)
      
      do_get
      assigns[:mentorship].should equal(@mentorship)
    end
    it "should redirect to '/mentorships' if no 'mentee_id' OR 'mentor_id' param exists" do
      get :new
      response.should redirect_to("/mentorships")
    end
    
    describe "sender and receiver" do
      # Let's us know who initiated this relationship
      
      it "should set the sender as the current user" do
        do_get
        assigns[:sender].should == @current_user
      end
      it "should set the sender_id on @mentorship to @sender.id" do
        do_get
        assigns[:mentorship].sender_id.should == @current_user.id
      end
      it "should set the receiver_id on @mentorship to @receiver.id" do
        do_get
        assigns[:mentorship].receiver_id.should == @mentor.id
      end      
      it "should set the receiver as the mentor if the current user is the mentee" do
        @mentor = mock_model(User, :id => 32, :skills => [], :user_skills => [])
        User.stub!(:find).with("32").and_return(@mentor)
        
        do_get({:mentor_id => @mentor.id})
        assigns[:receiver].should == @mentor
      end
      it "should set the receiver as the mentee if the current user is the mentor" do
        @mentee = mock_model(User, :id => 32, :skills => [], :user_skills => [])
        User.stub!(:find).with("32").and_return(@mentee)
        
        do_get({:mentee_id => @mentee.id})
        assigns[:receiver].should == @mentee
      end      
    end # sender and receiver

    
    describe "with a mentor_id" do
      before(:each) do        
        @user = mock_model(User, :skills => [], :user_skills => [])
        User.stub!(:find).and_return(@user)
      end
      def do_get
        get :new, :mentor_id => @user.id
      end
      
      it "should lookup the mentor_id" do
        User.should_receive(:find).and_return(@user)
        do_get
      end
      it "should assign the mentor as @mentor" do
        do_get
        assigns[:mentor].should equal(@user)
      end
      it "should assign the mentee as the current_user" do
        do_get
        assigns[:mentee].should == @current_user
      end
      it "should set @mentorship.mentor_id to the id of @mentor" do
        do_get
        assigns[:mentorship].mentor_id.should == @user.id
      end
    end # with a mentor_id
    describe "with a mentee_id" do
      before(:each) do
        @user = mock_model(User, :skills => [], :user_skills => [])
        User.stub!(:find).and_return(@user)
      end
      def do_get
        get :new, :mentee_id => @user.id
      end
      
      it "should lookup the mentee_id" do
        User.should_receive(:find).and_return(@user)
        do_get
      end
      it "should assign the mentee as @mentee" do
        do_get
        assigns[:mentee].should equal(@user)
      end
      it "should assign the mentor as the current_user" do
        do_get
        assigns[:mentor].should == @current_user
      end      
      it "should set @mentorship.mentee_id to the id of @mentee" do
        do_get
        assigns[:mentorship].mentee_id.should == @user.id
      end
    end # with a mentee_id    
  end # GET new

  describe "GET edit" do
    it "assigns the requested mentorship as @mentorship" do
      Mentorship.stub!(:find).with("37").and_return(mock_mentorship)
      get :edit, :id => "37"
      assigns[:mentorship].should equal(mock_mentorship)
    end
  end

  describe "POST create" do
    before(:each) do      
      @skills = {"19" => 1, "20" => 1}
      
      @skill = mock_model(Skill)
      Skill.stub!(:find).and_return(@skill)
    end    
    def do_post
      post :create, :mentorship => {}, :skills => @skills
    end
        
    describe "with valid params" do
      before(:each) do
        Mentorship.stub!(:new).with({}).and_return(mock_mentorship(:save => true, :skills= => true))
      end
      
      it "assigns a newly created mentorship as @mentorship" do
        do_post
        assigns[:mentorship].should equal(mock_mentorship)
      end
      
      it "should loop through the skills params and lookup skills" do        
        Skill.should_receive(:find).with("19").and_return(@skill)
        Skill.should_receive(:find).with("20").and_return(@skill)
        
        do_post
      end
      
      it "should set the skills of the mentorship based on" do
        mock_mentorship(:save => true)
        mock_mentorship.should_receive(:skills=).with([@skill, @skill]).and_return(true)
        
        do_post
      end

      it "redirects to the created mentorship" do
        Mentorship.stub!(:new).and_return(mock_mentorship(:save => true, :skills= => true))
        do_post
        response.should redirect_to(mentorship_url(mock_mentorship))
      end
    end
    
    describe "with invalid params" do
      it "assigns a newly created but unsaved mentorship as @mentorship" do
        Mentorship.stub!(:new).with({}).and_return(mock_mentorship(:save => false, :skills= => true))
        do_post
        assigns[:mentorship].should equal(mock_mentorship)
      end

      it "re-renders the 'new' template" do
        Mentorship.stub!(:new).and_return(mock_mentorship(:save => false, :skills= => true))
        do_post
        response.should render_template('new')
      end
    end
    
  end

  describe "PUT update" do
    
    describe "with valid params" do
      it "updates the requested mentorship" do
        Mentorship.should_receive(:find).with("37").and_return(mock_mentorship)
        mock_mentorship.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :mentorship => {:these => 'params'}
      end

      it "assigns the requested mentorship as @mentorship" do
        Mentorship.stub!(:find).and_return(mock_mentorship(:update_attributes => true))
        put :update, :id => "1"
        assigns[:mentorship].should equal(mock_mentorship)
      end

      it "redirects to the mentorship" do
        Mentorship.stub!(:find).and_return(mock_mentorship(:update_attributes => true))
        put :update, :id => "1"
        response.should redirect_to(mentorship_url(mock_mentorship))
      end
    end
    
    describe "with invalid params" do
      it "updates the requested mentorship" do
        Mentorship.should_receive(:find).with("37").and_return(mock_mentorship)
        mock_mentorship.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :mentorship => {:these => 'params'}
      end

      it "assigns the mentorship as @mentorship" do
        Mentorship.stub!(:find).and_return(mock_mentorship(:update_attributes => false))
        put :update, :id => "1"
        assigns[:mentorship].should equal(mock_mentorship)
      end

      it "re-renders the 'edit' template" do
        Mentorship.stub!(:find).and_return(mock_mentorship(:update_attributes => false))
        put :update, :id => "1"
        response.should render_template('edit')
      end
    end
    
  end

  describe "DELETE destroy" do
    it "destroys the requested mentorship" do
      Mentorship.should_receive(:find).with("37").and_return(mock_mentorship)
      mock_mentorship.should_receive(:destroy)
      delete :destroy, :id => "37"
    end
  
    it "redirects to the mentorships list" do
      Mentorship.stub!(:find).and_return(mock_mentorship(:destroy => true))
      delete :destroy, :id => "1"
      response.should redirect_to(mentorships_url)
    end
  end
  
  describe "GET respond" do
    before(:each) do
      @u1 = mock_model(User)
      @u2 = mock_model(User)
      
      @mentorship = mock_model(Mentorship, :sender => @u1, :mentee => @u1, :receiver => @u2, :mentor => @u2)
      Mentorship.stub!(:find).with(@mentorship.id.to_s).and_return(@mentorship)
    end
    def do_get
      get :respond, :id => @mentorship.id
    end
    
    it "should be successful" do
      do_get
      response.should be_success
    end
    it "should lookup the Mentorship by id" do
      Mentorship.should_receive(:find).with(@mentorship.id.to_s).and_return(@mentorship)
      do_get
    end
    it "should assign the found mentorship to @mentorship" do
      do_get
      assigns[:mentorship].should == @mentorship
    end
    it "should assign the mentorship's sender to @sender" do
      do_get
      assigns[:sender].should == @mentorship.sender
    end
    it "should assign the mentorship's sender to @sender" do
      do_get
      assigns[:sender].should == @mentorship.sender
    end
    it "should assign the mentorship's receiver to @receiver" do
      do_get
      assigns[:receiver].should == @mentorship.receiver
    end
    it "should assign the mentorship's mentor to @mentor" do
      do_get
      assigns[:mentor].should == @mentorship.mentor
    end
    it "should assign the mentorship's mentee to @mentee" do
      do_get
      assigns[:mentee].should == @mentorship.mentee
    end                
  end

end
