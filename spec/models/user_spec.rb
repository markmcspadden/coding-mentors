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
  end

  it "should create a new instance given valid attributes" do
    User.create!(@valid_attributes)
  end
end
