require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe PagesController do

  #Delete these examples and add some real ones
  it "should use PagesController" do
    controller.should be_an_instance_of(PagesController)
  end


  describe "GET 'index'" do
    it "should be successful" do
      get 'home'
      response.should be_success
    end
  end
end
