require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe MentorshipSkill do
  before(:each) do
    @valid_attributes = {
      :mentorship_id => 1,
      :skill_id => 1
    }
    
    @mentorship = MentorshipSkill.new(@valid_attributes)
  end

  it "should create a new instance given valid attributes" do
    @mentorship.should be_valid
  end
  
  describe "associations" do
    it "should have a skill" do
      @mentorship.should respond_to("skill")
    end
    it "should have a mentorship" do
      @mentorship.should respond_to("mentorship")      
    end
  end # associations
end
