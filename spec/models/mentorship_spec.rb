require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Mentorship do
  before(:each) do
    @valid_attributes = {
      :mentee_id => 1,
      :mentor_id => 1,
      :sender_id => 1,
      :receiver_id => 1,
      :accepted_at => Time.now,
      :rejected_at => Time.now,
      :completed_at => Time.now
    }
  end

  it "should create a new instance given valid attributes" do
    Mentorship.create!(@valid_attributes)
  end
end
