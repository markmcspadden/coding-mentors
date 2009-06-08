require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe UserSkillsController do

  def mock_user_skill(stubs={})
    @mock_user_skill ||= mock_model(UserSkill, stubs)
  end
  
  describe "GET index" do
    it "assigns all user_skills as @user_skills" do
      UserSkill.stub!(:find).with(:all).and_return([mock_user_skill])
      get :index
      assigns[:user_skills].should == [mock_user_skill]
    end
  end

  describe "GET show" do
    it "assigns the requested user_skill as @user_skill" do
      UserSkill.stub!(:find).with("37").and_return(mock_user_skill)
      get :show, :id => "37"
      assigns[:user_skill].should equal(mock_user_skill)
    end
  end

  describe "GET new" do
    it "assigns a new user_skill as @user_skill" do
      UserSkill.stub!(:new).and_return(mock_user_skill)
      get :new
      assigns[:user_skill].should equal(mock_user_skill)
    end
  end

  describe "GET edit" do
    it "assigns the requested user_skill as @user_skill" do
      UserSkill.stub!(:find).with("37").and_return(mock_user_skill)
      get :edit, :id => "37"
      assigns[:user_skill].should equal(mock_user_skill)
    end
  end

  describe "POST create" do
    
    describe "with valid params" do
      before(:each) do
        UserSkill.stub!(:new).and_return(mock_user_skill(:save => true))
      end
      
      it "assigns a newly created user_skill as @user_skill" do
        UserSkill.stub!(:new).with({'these' => 'params'}).and_return(mock_user_skill(:save => true))
        post :create, :user_skill => {:these => 'params'}
        assigns[:user_skill].should equal(mock_user_skill)
      end

      it "redirects to the created user_skill" do
        post :create, :user_skill => {}
        response.should redirect_to(user_skill_url(mock_user_skill))
      end
      
      # it "should responds with a JS alert on AJAX request" do
      #   page = mock("page")
      #   controller.should_receive(:render).with(:update).and_yield(page)
      #   page.should_receive(:alert).with(/success/i)
      #   
      #   post :create, :user_skill => {}, :format => "js"
      # end
      it "should render the skills partial on successful AJAX request" do
        # page = mock("page")
        # controller.should_receive(:render).with(:update).and_yield(page)
        # page.should_receive(:)
        @user = mock_model(User)
        
        mock_user_skill.should_receive(:level).and_return(0)
        mock_user_skill.should_receive(:user).and_return(@user)
        controller.should_receive(:render).with(:partial => "skills", :locals => {:level => 0, :user => @user})
        
        post :create, :user_skill => {:level => 0, :user_id => @user.id}, :format => "js"
      end
    end
    
    describe "with invalid params" do
      before(:each) do
        UserSkill.stub!(:new).and_return(mock_user_skill(:save => false))
        @errors = mock("errors", :full_messages => "Skill has already been assigned by you.")
        mock_user_skill.stub!(:errors).and_return(@errors)
      end
      
      it "assigns a newly created but unsaved user_skill as @user_skill" do
        UserSkill.stub!(:new).with({'these' => 'params'}).and_return(mock_user_skill(:save => false))
        post :create, :user_skill => {:these => 'params'}
        assigns[:user_skill].should equal(mock_user_skill)
      end

      it "re-renders the 'new' template" do
        post :create, :user_skill => {}
        response.should render_template('new')
      end
      
      # it "should responds with a JS alert on AJAX request" do
      #   page = mock("page")
      #   controller.should_receive(:render).with(:update).and_yield(page)
      #   page.should_receive(:alert).with(/failed/i)
      #   
      #   post :create, :user_skill => {}, :format => "js"
      # end
      it "should still render the skills partial on failed AJAX request" do
        # page = mock("page")
        # controller.should_receive(:render).with(:update).and_yield(page)
        # page.should_receive(:)
        @user = mock_model(User)
        
        mock_user_skill.should_receive(:level).and_return(0)
        mock_user_skill.should_receive(:user).and_return(@user)
        controller.should_receive(:render).with(:partial => "skills", :locals => {:level => 0, :user => @user, :errors => @errors.full_messages})
        
        post :create, :user_skill => {:level => 0, :user_id => @user.id}, :format => "js"
      end
    end
    
  end

  describe "PUT update" do
    
    describe "with valid params" do
      it "updates the requested user_skill" do
        UserSkill.should_receive(:find).with("37").and_return(mock_user_skill)
        mock_user_skill.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :user_skill => {:these => 'params'}
      end

      it "assigns the requested user_skill as @user_skill" do
        UserSkill.stub!(:find).and_return(mock_user_skill(:update_attributes => true))
        put :update, :id => "1"
        assigns[:user_skill].should equal(mock_user_skill)
      end

      it "redirects to the user_skill" do
        UserSkill.stub!(:find).and_return(mock_user_skill(:update_attributes => true))
        put :update, :id => "1"
        response.should redirect_to(user_skill_url(mock_user_skill))
      end
    end
    
    describe "with invalid params" do
      it "updates the requested user_skill" do
        UserSkill.should_receive(:find).with("37").and_return(mock_user_skill)
        mock_user_skill.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :user_skill => {:these => 'params'}
      end

      it "assigns the user_skill as @user_skill" do
        UserSkill.stub!(:find).and_return(mock_user_skill(:update_attributes => false))
        put :update, :id => "1"
        assigns[:user_skill].should equal(mock_user_skill)
      end

      it "re-renders the 'edit' template" do
        UserSkill.stub!(:find).and_return(mock_user_skill(:update_attributes => false))
        put :update, :id => "1"
        response.should render_template('edit')
      end
    end
    
  end

  describe "DELETE destroy" do
    it "destroys the requested user_skill" do
      UserSkill.should_receive(:find).with("37").and_return(mock_user_skill)
      mock_user_skill.should_receive(:destroy)
      delete :destroy, :id => "37"
    end
  
    it "redirects to the user_skills list" do
      UserSkill.stub!(:find).and_return(mock_user_skill(:destroy => true))
      delete :destroy, :id => "1"
      response.should redirect_to(user_skills_url)
    end
  end

end
