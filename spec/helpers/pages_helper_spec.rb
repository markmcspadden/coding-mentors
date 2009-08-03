require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe PagesHelper do
  
  #Delete this example and add some real ones or delete this file
  it "should be included in the object returned by #helper" do
    included_modules = (class << helper; self; end).send :included_modules
    included_modules.should include(PagesHelper)
  end
  
  describe "title skills" do
    it "should create some pretty title skill text" do
      @s1 = mock_model(Skill, :to_s => "Ruby")
      @s2 = mock_model(Skill, :to_s => "Erlang")

      helper.title_skills(@s2, @s1).should == "Learn <span class=\"title_skill\">Erlang</span> &nbsp;&nbsp;<small>or</small>&nbsp;&nbsp; Teach <span class=\"title_skill\">Ruby</span>"
    end
    
    it "should handle the case where the skills are both nil" do
      helper.title_skills(nil, nil).should == "Learn <span class=\"title_skill\"></span> &nbsp;&nbsp;<small>or</small>&nbsp;&nbsp; Teach <span class=\"title_skill\"></span>"
    end
  end # title skills


end
