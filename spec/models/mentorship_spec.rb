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

    @mentorship = Mentorship.new(@valid_attributes)
  end

  it "should create a new instance given valid attributes" do
    @mentorship.should be_valid
  end
  
  describe "associations" do
    it "should have a mentor" do
      @mentorship.should respond_to("mentor")
    end
    it "should have a mentee" do
      @mentorship.should respond_to("mentee")      
    end
    it "should have a sender" do
      @mentorship.should respond_to("sender")      
    end
    it "should have a receiver" do
      @mentorship.should respond_to("receiver")      
    end
    
  end # associations
end
