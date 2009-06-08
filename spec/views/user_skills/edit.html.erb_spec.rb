require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/user_skills/edit.html.erb" do
  include UserSkillsHelper
  
  before(:each) do
    assigns[:user_skill] = @user_skill = stub_model(UserSkill,
      :new_record? => false,
      :user_id => 1,
      :skill_id => 1,
      :level => 1
    )
  end

  it "renders the edit user_skill form" do
    render
    
    response.should have_tag("form[action=#{user_skill_path(@user_skill)}][method=post]") do
      with_tag('input#user_skill_user_id[name=?]', "user_skill[user_id]")
      with_tag('input#user_skill_skill_id[name=?]', "user_skill[skill_id]")
      with_tag('input#user_skill_level[name=?]', "user_skill[level]")
    end
  end
end


