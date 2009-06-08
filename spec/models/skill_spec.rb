require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Skill do
  before(:each) do
    @valid_attributes = {
      :name => "value for name"
    }
    
    @skill = Skill.new(@valid_attributes)
  end

  it "should create a new instance given valid attributes" do
    @skill.should be_valid
  end
  
  describe "associations" do
    it "should have user_skills" do
      @skill.should respond_to("user_skills")
    end
    it "should have users (through user_skills)" do
      @skill.should respond_to("users")
    end
  end #associations
end
