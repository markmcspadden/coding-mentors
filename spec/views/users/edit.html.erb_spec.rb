require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/users/edit.html.erb" do
  include UsersHelper
  
  before(:each) do
    assigns[:user] = @user = stub_model(User,
      :new_record? => false,
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

  it "renders the edit user form" do
    render
    
    response.should have_tag("form[action=#{user_path(@user)}][method=post]") do
      with_tag('input#user_name[name=?]', "user[name]")
      with_tag('textarea#user_master_skills[name=?]', "user[master_skills]")
      with_tag('textarea#user_intermediate_skills[name=?]', "user[intermediate_skills]")
      with_tag('textarea#user_newbie_skills[name=?]', "user[newbie_skills]")
      with_tag('input#user_remote_availability[name=?]', "user[remote_availability]")
      with_tag('input#user_local_availability[name=?]', "user[local_availability]")
      with_tag('input#user_available_to_mentor[name=?]', "user[available_to_mentor]")
      with_tag('input#user_available_to_be_mentored[name=?]', "user[available_to_be_mentored]")
    end
  end
end


