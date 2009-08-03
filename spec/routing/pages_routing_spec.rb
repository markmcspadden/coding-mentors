require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe PagesController do
  describe "route generation" do
    it "maps #home" do
      route_for(:controller => "pages", :action => "home").should == "/"
    end
  
    it "maps #search" do
      route_for(:controller => "pages", :action => "search").should == "/search"
    end
    
    it "maps #guides" do
      route_for(:controller => "pages", :action => "guides").should == "/guides"
    end
    
    it "maps #about" do
      route_for(:controller => "pages", :action => "about").should == "/about"
    end
    
    it "maps #error" do
      route_for(:controller => "pages", :action => "error").should == "/error"
    end
    
    it "maps #denied" do
      route_for(:controller => "pages", :action => "denied").should == "/denied"
    end            
  end
  
  describe "route recognition" do
    it "generates params for #home" do
      params_from(:get, "/").should == {:controller => "pages", :action => "home"}
    end
  
    it "generates params for #search" do
      params_from(:get, "/search").should == {:controller => "pages", :action => "search"}
    end
    
    it "generates params for #guides" do
      params_from(:get, "/guides").should == {:controller => "pages", :action => "guides"}
    end
    
    it "generates params for #about" do
      params_from(:get, "/about").should == {:controller => "pages", :action => "about"}
    end
    
    it "generates params for #error" do
      params_from(:get, "/error").should == {:controller => "pages", :action => "error"}
    end
    
    it "generates params for #denied" do
      params_from(:get, "/denied").should == {:controller => "pages", :action => "denied"}
    end                      
  end
end