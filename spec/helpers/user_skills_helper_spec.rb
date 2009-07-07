require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe UserSkillsHelper do
  before(:each) do
    @skill = mock_model(Skill, :name => "Rails")
    @user_skill = mock_model(UserSkill, :level => 6, :skill => @skill)
  end
  
  
  #Delete this example and add some real ones or delete this file
  it "is included in the helper object" do
    included_modules = (class << helper; self; end).send :included_modules
    included_modules.should include(UserSkillsHelper)
  end
  
  it "should display a user skill (level and name)" do
    helper.should_receive(:user_skill_image).with(@user_skill).and_return("IMAGES")
    
    helper.display_user_skill(@user_skill).should == "<span class=\"user_skill_images\">IMAGES</span>Rails"
  end
  
  describe "user skill image" do
    it "should get a Master image (6 on, 1 off)" do 
      @user_skill.stub!(:level).and_return(6)
           
      helper.should_receive(:on_image).exactly(6).times.and_return("ON IMAGE")
      helper.should_receive(:off_image).exactly(1).times.and_return("OFF IMAGE")
      helper.user_skill_image(@user_skill)
    end
    it "should accept a level as well as a user_skill object" do
      helper.should_receive(:on_image).exactly(6).times.and_return("ON IMAGE")
      helper.should_receive(:off_image).exactly(1).times.and_return("OFF IMAGE")
      helper.user_skill_image(6)
    end
    it "should get the on image" do
      helper.on_image.should match(/<img alt=\"On\" class=\"user_skill_image\" src=\"\/images\/pill_on.png?.*\" \/>/)
    end
    it "should get the off image" do
      helper.off_image.should match(/<img alt=\"Off\" class=\"user_skill_image\" src=\"\/images\/pill_off.png?.*\" \/>/)
    end
    
  end # user skill image
  
end
