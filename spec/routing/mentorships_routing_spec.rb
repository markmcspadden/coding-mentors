require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe MentorshipsController do
  describe "route generation" do
    it "maps #index" do
      route_for(:controller => "mentorships", :action => "index").should == "/mentorships"
    end
  
    it "maps #new" do
      route_for(:controller => "mentorships", :action => "new").should == "/mentorships/new"
    end
  
    it "maps #show" do
      route_for(:controller => "mentorships", :action => "show", :id => "1").should == "/mentorships/1"
    end
    
    it "maps #created" do
      route_for(:controller => "mentorships", :action => "created", :id => "1").should == "/mentorships/1/created"
    end    
  
    it "maps #edit" do
      route_for(:controller => "mentorships", :action => "edit", :id => "1").should == "/mentorships/1/edit"
    end

    it "maps #create" do
      route_for(:controller => "mentorships", :action => "create").should == {:path => "/mentorships", :method => :post}
    end

    it "maps #update" do
      route_for(:controller => "mentorships", :action => "update", :id => "1").should == {:path =>"/mentorships/1", :method => :put}
    end
  
    it "maps #destroy" do
      route_for(:controller => "mentorships", :action => "destroy", :id => "1").should == {:path =>"/mentorships/1", :method => :delete}
    end
    
    it "maps #respond" do
      route_for(:controller => "mentorships", :action => "respond", :id => "1").should == {:path =>"/mentorships/1/respond", :method => :get}
    end
  end

  describe "route recognition" do
    it "generates params for #index" do
      params_from(:get, "/mentorships").should == {:controller => "mentorships", :action => "index"}
    end
  
    it "generates params for #new" do
      params_from(:get, "/mentorships/new").should == {:controller => "mentorships", :action => "new"}
    end
  
    it "generates params for #create" do
      params_from(:post, "/mentorships").should == {:controller => "mentorships", :action => "create"}
    end
  
    it "generates params for #show" do
      params_from(:get, "/mentorships/1").should == {:controller => "mentorships", :action => "show", :id => "1"}
    end

    it "generates params for #created" do
      params_from(:get, "/mentorships/1/created").should == {:controller => "mentorships", :action => "created", :id => "1"}
    end
  
    it "generates params for #edit" do
      params_from(:get, "/mentorships/1/edit").should == {:controller => "mentorships", :action => "edit", :id => "1"}
    end
  
    it "generates params for #update" do
      params_from(:put, "/mentorships/1").should == {:controller => "mentorships", :action => "update", :id => "1"}
    end
  
    it "generates params for #destroy" do
      params_from(:delete, "/mentorships/1").should == {:controller => "mentorships", :action => "destroy", :id => "1"}
    end
    
    it "generates params for #respond" do
      params_from(:get, "/mentorships/1/respond").should == {:controller => "mentorships", :action => "respond", :id => "1"}
    end    
  end
end
