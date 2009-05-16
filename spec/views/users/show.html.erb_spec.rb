require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/users/show.html.erb" do
  include UsersHelper
  before(:each) do
    assigns[:user] = @user = stub_model(User,
      :name => "value for name",
      :master_skills => "value for master_skills",
      :intermediate_skills => "value for intermediate_skills",
      :newbie_skills => "value for newbie_skills",
      :remote_availability => "value for remote_availability",
      :local_availability => "value for local_availability",
      :available_to_mentor => false,
      :available_to_be_mentored => false
    )
  end

  it "renders attributes in <p>" do
    render
    response.should have_text(/value\ for\ name/)
    response.should have_text(/value\ for\ master_skills/)
    response.should have_text(/value\ for\ intermediate_skills/)
    response.should have_text(/value\ for\ newbie_skills/)
    response.should have_text(/value\ for\ remote_availability/)
    response.should have_text(/value\ for\ local_availability/)
    response.should have_text(/false/)
    response.should have_text(/false/)
  end
end

