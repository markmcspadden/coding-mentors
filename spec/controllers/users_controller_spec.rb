require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe UsersController do
  it_should_behave_like "AuthorizedController"
  
  def mock_user(stubs={})
    @mock_user ||= mock_model(User, stubs)
  end
  
  describe "authorization" do
    before(:each) do
      controller.stub!(:administrator?).and_return(false)
    end
    
    it "should user has_permission? to handle default cases" do
      
    end
    # SPOT CHECK?
    describe "edit" do
      it "should not allow edit_availability for a user that's not the fetched user" do
        User.stub!(:find).with("37").and_return(@current_user)
        @current_user.stub!(:is_readable_by).and_return(true)
        @current_user.stub!(:is_updatable_by).and_return(false)

        get :edit, :id => "37"
        response.should redirect_to denied_path
      end
      it "should allow edit_availability for a user that's not the fetched user" do
        User.stub!(:find).with("37").and_return(@current_user)
        @current_user.stub!(:is_updatable_by).and_return(true)

        get :edit, :id => "37"
        response.should be_success
      end
    end # edit
    
    describe "edit_availability" do
      it "should not allow edit_availability for a user that's not the fetched user" do
        User.stub!(:find).with("37").and_return(mock_user)
        @mock_user.stub!(:is_readable_by).and_return(true)
        @mock_user.stub!(:is_updatable_by).and_return(false)

        get :edit_availability, :id => "37"
        response.should redirect_to denied_path
      end
      it "should allow edit_availability for a user that's not the fetched user" do
        User.stub!(:find).with("37").and_return(mock_user)
        @mock_user.stub!(:is_readable_by).and_return(true)
        @mock_user.stub!(:is_updatable_by).and_return(true)

        get :edit_availability, :id => "37"
        response.should be_success
      end      
    end # edit_availability

  end  
  
  describe "GET index" do
    it "assigns all users as @users" do
      User.stub!(:find).with(:all).and_return([mock_user])
      get :index
      assigns[:users].should == [mock_user]
    end
  end

  describe "GET show" do
    it "assigns the requested user as @user" do
      User.should_receive(:find).with("37", :include => [:skills]).and_return(mock_user)
      get :show, :id => "37"
      assigns[:user].should equal(mock_user)
    end
  end

  describe "GET new" do
    it "assigns a new user as @user" do
      User.stub!(:new).and_return(mock_user)
      get :new
      assigns[:user].should equal(mock_user)
    end
  end

  describe "GET edit" do
    it "assigns the requested user as @user" do
      User.stub!(:find).with("37").and_return(mock_user)
      get :edit, :id => "37"
      assigns[:user].should equal(mock_user)
    end
  end
  
  describe "GET edit_availability" do
    it "should assign the requested user as @user" do
      User.stub!(:find).with("37").and_return(mock_user)
      get :edit, :id => "37"
      assigns[:user].should equal(mock_user)      
    end
  end

  describe "POST create" do
    
    describe "with valid params" do
      before(:each) do
        @user = mock_user(:save => true, :errors => [])
        User.stub!(:new).and_return(@user)
      end
      
      it "should call the recaptcha validation" do
        controller.should_receive(:verify_recaptcha).with(@user)
        post :create, :user => {}
      end
      
      it "assigns a newly created user as @user" do
        User.stub!(:new).with({'these' => 'params'}).and_return(@user)
        post :create, :user => {:these => 'params'}
        assigns[:user].should equal(mock_user)
      end

      it "redirects to the created user" do
        post :create, :user => {}
        response.should redirect_to(user_url(mock_user))
      end
    end
    
    describe "with invalid params" do
      it "assigns a newly created but unsaved user as @user" do
        User.stub!(:new).with({'these' => 'params'}).and_return(mock_user(:save => false))
        post :create, :user => {:these => 'params'}
        assigns[:user].should equal(mock_user)
      end

      it "re-renders the 'new' template" do
        User.stub!(:new).and_return(mock_user(:save => false))
        post :create, :user => {}
        response.should render_template('new')
      end
    end
    
  end

  describe "PUT update" do
    
    describe "with valid params" do
      it "updates the requested user" do
        User.should_receive(:find).with("37").and_return(mock_user)
        mock_user.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :user => {:these => 'params'}
      end

      it "assigns the requested user as @user" do
        User.stub!(:find).and_return(mock_user(:update_attributes => true))
        put :update, :id => "1"
        assigns[:user].should equal(mock_user)
      end

      it "redirects to the user" do
        User.stub!(:find).and_return(mock_user(:update_attributes => true))
        put :update, :id => "1"
        response.should redirect_to(user_url(mock_user))
      end
    end
    
    describe "with invalid params" do
      it "updates the requested user" do
        User.should_receive(:find).with("37").and_return(mock_user)
        mock_user.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :user => {:these => 'params'}
      end

      it "assigns the user as @user" do
        User.stub!(:find).and_return(mock_user(:update_attributes => false))
        put :update, :id => "1"
        assigns[:user].should equal(mock_user)
      end

      it "re-renders the 'edit' template" do
        User.stub!(:find).and_return(mock_user(:update_attributes => false))
        put :update, :id => "1"
        response.should render_template('edit')
      end
    end
    
  end

  describe "DELETE destroy" do
    it "destroys the requested user" do
      User.should_receive(:find).with("37").and_return(mock_user)
      mock_user.should_receive(:destroy)
      delete :destroy, :id => "37"
    end
  
    it "redirects to the users list" do
      User.stub!(:find).and_return(mock_user(:destroy => true))
      delete :destroy, :id => "1"
      response.should redirect_to(users_url)
    end
  end

end
