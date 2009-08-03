require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe PagesController do
  describe "route generation" do
    it "maps #home" do
      route_for(:controller => "pages", :action => "home").should == "/"
    end
  
    it "maps #search" do
      route_for(:controller => "pages", :action => "search").should == "/search"
    end
  end
  
  describe "route recognition" do
    it "generates params for #home" do
      params_from(:get, "/").should == {:controller => "pages", :action => "home"}
    end
  
    it "generates params for #search" do
      params_from(:get, "/search").should == {:controller => "pages", :action => "search"}
    end  
  end
end