require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe PagesHelper do
  
  #Delete this example and add some real ones or delete this file
  it "should be included in the object returned by #helper" do
    included_modules = (class << helper; self; end).send :included_modules
    included_modules.should include(PagesHelper)
  end
  
  it "should create some pretty title skill text" do
    @s1 = mock_model(Skill, :name => "Ruby")
    @s2 = mock_model(Skill, :name => "Erlang")
    
    helper.title_skills(@s2, @s1).should == "Learn <span class=\"title_skill\">Erlang</span> &nbsp;&nbsp;<small>or</small>&nbsp;&nbsp; Teach <span class=\"title_skill\">Ruby</span>"
  end

end
