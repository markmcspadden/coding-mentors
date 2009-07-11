require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe ApplicationHelper do
  
  #Delete this example and add some real ones or delete this file
  it "is included in the helper object" do
    included_modules = (class << helper; self; end).send :included_modules
    included_modules.should include(ApplicationHelper)
  end
  
  it "should display a date in a decent format" do
    now = "2005-07-23 14:00:00".to_time
    helper.display_date(now).should == "July 23, 2005"
  end
  
end
