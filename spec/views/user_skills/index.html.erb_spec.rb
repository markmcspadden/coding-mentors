require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/user_skills/index.html.erb" do
  include UserSkillsHelper
  
  before(:each) do
    assigns[:user_skills] = [
      stub_model(UserSkill,
        :user_id => 1,
        :skill_id => 1,
        :level => 1
      ),
      stub_model(UserSkill,
        :user_id => 1,
        :skill_id => 1,
        :level => 1
      )
    ]
  end

  it "renders a list of user_skills" do
    render
    response.should have_tag("tr>td", 1.to_s, 2)
    response.should have_tag("tr>td", 1.to_s, 2)
    response.should have_tag("tr>td", 1.to_s, 2)
  end
end

