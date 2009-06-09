require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe User do
  before(:each) do
    @valid_attributes = {
      :name => "value for name",
      :master_skills => "value for master_skills",
      :intermediate_skills => "value for intermediate_skills",
      :newbie_skills => "value for newbie_skills",
      :remote_availability => "value for remote_availability",
      :local_availability => "value for local_availability",
      :available_to_mentor => false,
      :available_to_be_mentored => false
    }
    
    @user = User.new(@valid_attributes)
  end

  it "should create a new instance given valid attributes" do
    @user.should be_valid
  end
  it "should give the name as the to_s method" do
    @user.to_s.should == "value for name"
  end
  
  describe "associations" do
    it "should have user_skills" do
      @user.should respond_to("user_skills")
    end
    it "should have skills (through user_skills)" do
      @user.should respond_to("skills")
    end
  end # associations
  

  
  describe "user skills and skills by level" do
    before(:each) do
      @s0 = mock_model(Skill)
      @s1 = mock_model(Skill)
      @s2 = mock_model(Skill)
      
      @us0 = mock_model(UserSkill, :skill => @s0, :level => 0)
      @us1 = mock_model(UserSkill, :skill => @s1, :level => 1)
      @us2 = mock_model(UserSkill, :skill => @s2, :level => 2)
      
      @user.stub!(:user_skills).and_return([@us0, @us1, @us2])
      @user.stub!(:skills).and_return([@s0, @s1, @s2])
    end 
    it "should find the user skills by level" do
      @user.user_skills_by_level(0).should == [@us0]
      @user.user_skills_by_level(1).should == [@us1]
      @user.user_skills_by_level(2).should == [@us2]
    end   
    it "should find the skills by level" do
      @user.skills_by_level(0).should == [@s0]
      @user.skills_by_level(1).should == [@s1]
      @user.skills_by_level(2).should == [@s2]
    end
    it "should have novice user skills" do
      pending "not yet implemented"
    end
    it "should have intermediate user skills" do
      pending "not yet implemented"      
    end
    it "should have master user skills" do
      pending "not yet implemented"      
    end    
    it "should have novice skills" do
      pending "not yet implemented"      
    end
    it "should have intermediate skills" do
      pending "not yet implemented"      
    end
    it "should have master skills" do
      pending "not yet implemented"      
    end
  end # skills (by level)
end
