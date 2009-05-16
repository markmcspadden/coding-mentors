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
    it "assigns a new mentorship as @mentorship" do
      Mentorship.stub!(:new).and_return(mock_mentorship)
      get :new
      assigns[:mentorship].should equal(mock_mentorship)
    end
  end

  describe "GET edit" do
    it "assigns the requested mentorship as @mentorship" do
      Mentorship.stub!(:find).with("37").and_return(mock_mentorship)
      get :edit, :id => "37"
      assigns[:mentorship].should equal(mock_mentorship)
    end
  end

  describe "POST create" do
    
    describe "with valid params" do
      it "assigns a newly created mentorship as @mentorship" do
        Mentorship.stub!(:new).with({'these' => 'params'}).and_return(mock_mentorship(:save => true))
        post :create, :mentorship => {:these => 'params'}
        assigns[:mentorship].should equal(mock_mentorship)
      end

      it "redirects to the created mentorship" do
        Mentorship.stub!(:new).and_return(mock_mentorship(:save => true))
        post :create, :mentorship => {}
        response.should redirect_to(mentorship_url(mock_mentorship))
      end
    end
    
    describe "with invalid params" do
      it "assigns a newly created but unsaved mentorship as @mentorship" do
        Mentorship.stub!(:new).with({'these' => 'params'}).and_return(mock_mentorship(:save => false))
        post :create, :mentorship => {:these => 'params'}
        assigns[:mentorship].should equal(mock_mentorship)
      end

      it "re-renders the 'new' template" do
        Mentorship.stub!(:new).and_return(mock_mentorship(:save => false))
        post :create, :mentorship => {}
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

end
