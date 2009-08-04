require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe Mentorship, "authorization" do
  before(:each) do
    @u1 = User.new
    @u2 = User.new
    @admin = User.new
    @admin.stub!(:is_admin?).and_return(true)
    
    @m1 = Mentorship.new
    @m1.stub!(:sender).and_return(@u1)
    @m1.stub!(:receiver).and_return(@u2)    
  end
    
  describe "update" do
    it "should be allowed by the sender" do
      @m1.is_updatable_by(@u1).should be_true
    end
    it "should be allowed by the receiver" do
      @m1.is_updatable_by(@u2).should be_true
    end
    it "should not be allowed by another user" do
      @m1.is_updatable_by(User.new).should be_false
    end
  end # update
  
  describe "delete" do
    it "should not be allowed...at all" do
      @m1.is_deletable_by(@u1).should be_false
      @m1.is_deletable_by(@u2).should be_false
      @m1.is_deletable_by(@admin).should be_false
    end
  end # delete
  
  describe "read" do
    it "should be allowed for admin only" do
      @m1.is_readable_by(@u1).should be_false
      @m1.is_readable_by(@u2).should be_false
      @m1.is_readable_by(@admin).should be_true            
    end
  end # read
  
  describe "index" do
    it "should be allowed for admin only" do
      Mentorship.is_indexable_by(@u1).should be_false
      Mentorship.is_indexable_by(@u2).should be_false
      Mentorship.is_indexable_by(@admin).should be_true      
    end
  end # index
  
  describe "create" do
    it "should be allowed for all" do
      Mentorship.is_creatable_by(@u1).should be_true
      Mentorship.is_creatable_by(@u2).should be_true
      Mentorship.is_creatable_by(nil).should be_true      
    end
  end # create
  
  describe "respond" do
    it "should only be the receiver" do
      @m1.is_respondable_by(@u1).should be_false
      @m1.is_respondable_by(@u2).should be_true
      @m1.is_respondable_by(nil).should be_false      
    end
  end

end