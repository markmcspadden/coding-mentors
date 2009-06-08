require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe UserSkillsController do
  describe "route generation" do
    it "maps #index" do
      route_for(:controller => "user_skills", :action => "index").should == "/user_skills"
    end
  
    it "maps #new" do
      route_for(:controller => "user_skills", :action => "new").should == "/user_skills/new"
    end
  
    it "maps #show" do
      route_for(:controller => "user_skills", :action => "show", :id => "1").should == "/user_skills/1"
    end
  
    it "maps #edit" do
      route_for(:controller => "user_skills", :action => "edit", :id => "1").should == "/user_skills/1/edit"
    end

  it "maps #create" do
    route_for(:controller => "user_skills", :action => "create").should == {:path => "/user_skills", :method => :post}
  end

  it "maps #update" do
    route_for(:controller => "user_skills", :action => "update", :id => "1").should == {:path =>"/user_skills/1", :method => :put}
  end
  
    it "maps #destroy" do
      route_for(:controller => "user_skills", :action => "destroy", :id => "1").should == {:path =>"/user_skills/1", :method => :delete}
    end
  end

  describe "route recognition" do
    it "generates params for #index" do
      params_from(:get, "/user_skills").should == {:controller => "user_skills", :action => "index"}
    end
  
    it "generates params for #new" do
      params_from(:get, "/user_skills/new").should == {:controller => "user_skills", :action => "new"}
    end
  
    it "generates params for #create" do
      params_from(:post, "/user_skills").should == {:controller => "user_skills", :action => "create"}
    end
  
    it "generates params for #show" do
      params_from(:get, "/user_skills/1").should == {:controller => "user_skills", :action => "show", :id => "1"}
    end
  
    it "generates params for #edit" do
      params_from(:get, "/user_skills/1/edit").should == {:controller => "user_skills", :action => "edit", :id => "1"}
    end
  
    it "generates params for #update" do
      params_from(:put, "/user_skills/1").should == {:controller => "user_skills", :action => "update", :id => "1"}
    end
  
    it "generates params for #destroy" do
      params_from(:delete, "/user_skills/1").should == {:controller => "user_skills", :action => "destroy", :id => "1"}
    end
  end
end
