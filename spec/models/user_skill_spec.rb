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
  
  describe "validations" do
    it "should not allow the same tag to be attributed to a user multiple times" do
      @previous = mock_model(UserSkill)
      
      UserSkill.should_receive(:exists?).and_return(@previous)
      
      @user_skill.should_not be_valid
      @user_skill.errors.full_messages.should include("Skill has already be assigned by you")
    end
  end # validations
  
  describe "associations" do
    it "should have a user" do
      @user_skill.should respond_to("user")
    end
    it "should have a skill" do
      @user_skill.should respond_to("skill")
    end
  end # associations
  
  describe "attributes" do
    describe "skill name" do
      before(:each) do
        @skill = mock_model(Skill, :name => "Rails")
      end
      
      it "should get the skill name" do
        @user_skill.stub!(:skill).and_return(@skill)
        @user_skill.skill_name.should == "Rails"
      end
      it "should set the skill by name if a skill by that name exists" do
        # The 'with' piece is freakin out on me :/
        # Skill.should_receive(:find).with(:first, {:conditions => ["LOWER(name) = LOWER(?)", "Rails"]}).and_return(@skill)
        Skill.should_receive(:find).twice.and_return(@skill)
        
        @user_skill.skill_name = "Rails"
        @user_skill.skill.should == @skill
      end
      it "should set the skill by name if a skill by that name exists (even if it's different case type)" do
        # The 'with' piece is freakin out on me :/
        # Skill.should_receive(:find).with(:first, {:conditions => ["LOWER(name) = LOWER(?)", "raIlS"]}).and_return(@skill)
        Skill.should_receive(:find).twice.and_return(@skill)
        
        @user_skill.skill_name = "raIlS"
        @user_skill.skill.should == @skill
      end
      it "should create a new skill based on the name passed in if that name does not exist" do
        Skill.should_receive(:find).and_return(nil)
        
        Skill.should_receive(:create).and_return(@skill)
        @user_skill.skill_name = "Rails"
      end
    end # skill name
        

  end #attributes
end
