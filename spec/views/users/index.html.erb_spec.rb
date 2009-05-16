require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/users/index.html.erb" do
  include UsersHelper
  
  before(:each) do
    assigns[:users] = [
      stub_model(User,
        :name => "value for name",
        :master_skills => "value for master_skills",
        :intermediate_skills => "value for intermediate_skills",
        :newbie_skills => "value for newbie_skills",
        :remote_availability => "value for remote_availability",
        :local_availability => "value for local_availability",
        :available_to_mentor => false,
        :available_to_be_mentored => false
      ),
      stub_model(User,
        :name => "value for name",
        :master_skills => "value for master_skills",
        :intermediate_skills => "value for intermediate_skills",
        :newbie_skills => "value for newbie_skills",
        :remote_availability => "value for remote_availability",
        :local_availability => "value for local_availability",
        :available_to_mentor => false,
        :available_to_be_mentored => false
      )
    ]
  end

  it "renders a list of users" do
    render
    response.should have_tag("tr>td", "value for name".to_s, 2)
    response.should have_tag("tr>td", "value for master_skills".to_s, 2)
    response.should have_tag("tr>td", "value for intermediate_skills".to_s, 2)
    response.should have_tag("tr>td", "value for newbie_skills".to_s, 2)
    response.should have_tag("tr>td", "value for remote_availability".to_s, 2)
    response.should have_tag("tr>td", "value for local_availability".to_s, 2)
    response.should have_tag("tr>td", false.to_s, 2)
    response.should have_tag("tr>td", false.to_s, 2)
  end
end

