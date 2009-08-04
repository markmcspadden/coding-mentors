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
  
  describe "user skill comparison" do
    before(:each) do
      helper.stub!(:current_user).and_return(mock_model(User))
      @u1 = mock_model(User, :name => "Mark McSpadden")
      @u2 = mock_model(User, :name => "Dave Kruse")
      
      @us1 = mock_model(UserSkill, :skill => @skill, :user => @u1, :level => 4)
      @us2 = mock_model(UserSkill, :skill => @skill, :user => @u2, :level => 3)
      
      helper.stub!(:user_skill_image).with(@us1.level).and_return("4")
      helper.stub!(:user_skill_image).with(@us2.level).and_return("3")
    end
    
    it "should compare two user's skills" do      
      comparison_html = <<-EOS
        <span class="mentorship_skills">
          4 Mark McSpadden's Level
        </span><br/>
        <span class="mentorship_skills">
          3 Dave Kruse's Level
        </span>
      EOS
      
      helper.skill_comparison(@skill, @us1, @us2).should == comparison_html.strip.gsub(/\n\s*/,"")     
    end
    
    it "should acknowledge the current_user with 'Your Level' inside of generic 'Name Level'" do
      helper.stub!(:current_user).and_return(@u2)
      comparison_html = <<-EOS
        <span class="mentorship_skills">
          4 Mark McSpadden's Level
        </span><br/>
        <span class="mentorship_skills">
          3 Your Level
        </span>
      EOS
      
      helper.skill_comparison(@skill, @us1, @us2).should == comparison_html.strip.gsub(/\n\s*/,"")      
    end
    
    it "should handle the situation where one person does not actually have the skill being compared" do
      helper.stub!(:current_user).and_return(@u2)
      comparison_html = <<-EOS
        <span class="mentorship_skills">
          4 Mark McSpadden's Level
        </span>
      EOS
      
      helper.skill_comparison(@skill, @us1, nil).should == comparison_html.strip.gsub(/\n\s*/,"")      
    end    
  end # user skill comparison
  
end
