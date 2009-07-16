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
      Skill.levels.should == [ ["Innocent", 1, "I know it exists"],
                                ["Exposed", 2, "I know I need it"],
                                ["Apprentice", 3, "I've tried it with supervision"],
                                ["Practitioner", 4, "I've been trained and used it a few times"],
                                ["Journeyman", 5, "I've got this down"],
                                ["Master", 6, "I know this inside and outside"],
                                ["Researcher", 7, "I'm working on improving or extending the skill itself"] ]
    end
  end # class methods
end
