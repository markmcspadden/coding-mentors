require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe User, "authorization" do
  before(:each) do
    @u1 = User.new
    @u2 = User.new    
  end
  
  describe "administrator" do
    it "should not be anyone" do
      @u1.should_not be_administrator
      @u2.should_not be_administrator      
    end
    it "should be aliased as is_admin?" do
      @u1.administrator?.should == @u1.is_admin?
    end
  end # administrator
  
  describe "update" do
    it "should be allowed by the user" do
      @u1.is_updatable_by(@u1).should be_true
    end
    
    it "should not be allowed by another user" do
      @u1.is_updatable_by(@u2).should be_false
    end
  end # update
  
  describe "delete" do
    it "should not be allowed...at all" do
      @u1.is_deletable_by(@u1).should be_false
      @u1.is_deletable_by(@u2).should be_false
    end
  end # delete
  
  describe "read" do
    it "should be allowed for all" do
      @u1.is_readable_by(@u1).should be_true
      @u1.is_readable_by(@u2).should be_true
      @u1.is_readable_by(nil).should be_true            
    end
  end # read
  
  describe "index" do
    it "should be allowed for all" do
      User.is_indexable_by(@u1).should be_true
      User.is_indexable_by(@u2).should be_true
      User.is_indexable_by(nil).should be_true      
    end
  end # index
  
  describe "create" do
    it "should be allowed for all" do
      User.is_creatable_by(@u1).should be_true
      User.is_creatable_by(@u2).should be_true
      User.is_creatable_by(nil).should be_true      
    end
  end # create

end