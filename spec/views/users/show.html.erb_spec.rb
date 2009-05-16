require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/users/show.html.erb" do
  include UsersHelper
  before(:each) do
    pending "We don't do view specs"
    
    assigns[:user] = @user = stub_model(User,
      :name => "value for name",
      :master_skills => "value for master_skills",
      :intermediate_skills => "value for intermediate_skills",
      :newbie_skills => "value for newbie_skills",
      :remote_availability => "value for remote_availability",
      :local_availability => "value for local_availability",
      :available_to_mentor => true,
      :available_to_be_mentored => true
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
    
    # Availablility
    response.should have_text("<a href=\"#\" onclick=\"alert('Not Yet');; return false;\">Available as a Mentor</a>")
    response.should have_text("<a href=\"#\" onclick=\"alert('Not Yet');; return false;\">Looking for a Mentor</a>")
  end
end

