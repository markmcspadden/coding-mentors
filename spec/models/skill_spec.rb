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
      Skill.levels.should == [ ["Innocent", 1],
                                ["Exposed", 2],
                                ["Apprentice", 3],
                                ["Practitioner", 4],
                                ["Journeyman", 5],
                                ["Master", 6],
                                ["Researcher", 7] ]
    end
    it "should have skill level descriptions" do
      Skill.level_descriptions.should == [ ["Innocent", "I know it exists"], 
                                            ["Exposed", "I know I need it"],
                                            ["Apprentice", "I've tried it with supervision"],
                                            ["Practitioner", "I've been trained and used it a few times"],
                                            ["Journeyman", "I've got this down"],
                                            ["Master", "I know this inside and outside"],
                                            ["Researcher", "I'm working on improving the skill itself"] ]
    end
  end # class methods
end
