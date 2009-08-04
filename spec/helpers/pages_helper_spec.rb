require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe PagesHelper do
  
  #Delete this example and add some real ones or delete this file
  it "should be included in the object returned by #helper" do
    included_modules = (class << helper; self; end).send :included_modules
    included_modules.should include(PagesHelper)
  end
  
  describe "page helper" do
    before(:each) do
      helper.instance_variable_set("@user", nil)
    end
    
    it "should refer to a user in the title and their top 5 skills if on a user page" do
      @skills = ["Ruby", "Java", "Erlang", "CSS", "jQuery", "BBQ"]
      
      @user = User.new(:name => "Mark McSpadden")
      @user.stub!(:skills).and_return(@skills)
      
      helper.instance_variable_set("@user", @user)
      
      helper.page_title.should == "Coding Mentors: Mark McSpadden - Ruby, Java, Erlang, CSS, jQuery"
    end
    
    it "should be 'Coding Mentors' by defaults" do
      helper.page_title.should == "Coding Mentors: Helping Software Developers Help Software Developers"
    end
  end
  
  describe "title skills" do
    it "should create some pretty title skill text" do
      @s1 = mock_model(Skill, :to_s => "Ruby")
      @s2 = mock_model(Skill, :to_s => "Erlang")

      helper.title_skills(@s2, @s1).should == "Learn <a href=\"/search?q=Erlang\" class=\"title_skill\">Erlang</a> &nbsp;&nbsp;<small>or</small>&nbsp;&nbsp; Teach <a href=\"/search?q=Ruby\" class=\"title_skill\">Ruby</a>"
    end
    
    it "should handle the case where the skills are both nil" do
      helper.title_skills(nil, nil).should == "Learn <a href=\"/search?q=\" class=\"title_skill\"></a> &nbsp;&nbsp;<small>or</small>&nbsp;&nbsp; Teach <a href=\"/search?q=\" class=\"title_skill\"></a>"
    end
  end # title skills


end
