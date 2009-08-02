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
  
  describe "singelton methods" do
    it "should have a set of skill levels" do
      Skill.levels.should == [ [1, "Innocent", "I know it exists"],
                                [2, "Exposed", "I know I need it"],
                                [3, "Apprentice", "I've tried it with supervision"],
                                [4, "Practitioner", "I've been trained and used it a few times"],
                                [5, "Journeyman", "I've got this down"],
                                [6, "Master", "I know this inside and outside"],
                                [7, "Researcher", "I'm working on improving or extending the skill itself"] ]
    end
    
    # NOTE: There is a plugin for this 
    # If it starts being used alot in other places it'd probably be a good idea to look into
    # http://github.com/mshiltonj/active_record_random_find/tree/master
    it "should get a random user" do
      @ids = [{"id"=>"1"}, {"id"=>"2"}, {"id"=>"3"}, 
              {"id"=>"4"}, {"id"=>"5"}, {"id"=>"6"},
              {"id"=>"7"}, {"id"=>"8"}, {"id"=>"9"}]
      
      Skill.connection.should_receive(:select_all).with("SELECT id FROM skills").and_return(@ids)
      
      # TODO: Mock out the rand function
      # It's kind of hard to get it to return different values each time
      # 6.times do |i|
      #   Skill.should_receive(:rand).and_return(i)
      # end
      
      Skill.should_receive(:find) #.with([1,2,3]) # Once the rand is mocked we can add the 'with'
      
      Skill.random(3)
    end    
  end # singleton methods
end
