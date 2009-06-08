require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/user_skills/show.html.erb" do
  include UserSkillsHelper
  before(:each) do
    assigns[:user_skill] = @user_skill = stub_model(UserSkill,
      :user_id => 1,
      :skill_id => 1,
      :level => 1
    )
  end

  it "renders attributes in <p>" do
    render
    response.should have_text(/1/)
    response.should have_text(/1/)
    response.should have_text(/1/)
  end
end

