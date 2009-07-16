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
  
  it "should display the name as the default to_s" do
    @skill.to_s.should == "value for name"
  end
  
  describe "associations" do
    it "should have user_skills" do
      @skill.should respond_to("user_skills")
    end
    it "should have users (through user_skills)" do
      @skill.should respond_to("users")
    end
  end #associations
  
  describe "class methods" do
    it "should have a set of skill levels" do
      Skill.levels.should == [ [1, "Innocent", "I know it exists"],
                                [2, "Exposed", "I know I need it"],
                                [3, "Apprentice", "I've tried it with supervision"],
                                [4, "Practitioner", "I've been trained and used it a few times"],
                                [5, "Journeyman", "I've got this down"],
                                [6, "Master", "I know this inside and outside"],
                                [7, "Researcher", "I'm working on improving or extending the skill itself"] ]
    end
  end # class methods
end
