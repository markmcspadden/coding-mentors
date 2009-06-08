require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe UserSkill do
  before(:each) do
    @valid_attributes = {
      :user_id => 1,
      :skill_id => 1,
      :level => 1
    }

    @user_skill = UserSkill.new(@valid_attributes)
  end

  it "should create a new instance given valid attributes" do
    @user_skill.should be_valid
  end
  
  describe "associations" do
    it "should have a user" do
      @user_skill.should respond_to("user")
    end
    it "should have a skill" do
      @user_skill.should respond_to("skill")
    end
  end # associations
end
