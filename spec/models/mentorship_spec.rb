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
  
  describe "life cycle" do
    before(:each) do
      @mentee = mock_model(User)
      @mentor = mock_model(User)
      
      @mentorship.mentee = @mentee
      @mentorship.mentor = @mentor
    end
    
    describe "when the mentorship is created" do
      def after_create
        @mentorship.after_create
      end
      
      it "should send an email to mentor if the mentee is the sender" do
        @mentorship.sender = @mentee
        @mentorship.receiver = @mentor
        
        MentorshipMailer.should_receive(:deliver_new_mentorship_to_mentor).with(@mentorship).and_return(true)
        
        after_create
      end
      it "should send an email to the mentee if the mentor is the sender" do
        @mentorship.sender = @mentor
        @mentorship.receiver = @mentee
        
        MentorshipMailer.should_receive(:deliver_new_mentorship_to_mentee).with(@mentorship).and_return(true)
        
        after_create        
      end
    end # created
    describe "when the mentorship is updated" do
      before(:each) do
        MentorshipMailer.stub!(:deliver_accepted_mentorship_to_mentor)
        MentorshipMailer.stub!(:deliver_accepted_mentorship_to_mentee)
      end
      
      def after_update
        @mentorship.after_update
      end
      
      describe "if the mentorship is accepted" do
        before(:each) do
          @mentorship.accepted_at = Time.now
        end
        
        it "should send an email to mentor" do
          MentorshipMailer.should_receive(:deliver_accepted_mentorship_to_mentor).with(@mentorship).and_return(true)

          after_update
        end
        it "should send an email to the mentee" do
          MentorshipMailer.should_receive(:deliver_accepted_mentorship_to_mentee).with(@mentorship).and_return(true)

          after_update
        end
      end    
      describe "if the mentorship is rejected" do
        before(:each) do
          @mentorship.rejected_at = Time.now
        end
        
        it "should send an email to mentor if the mentor is the original sender" do
          @mentorship.sender = @mentor
          @mentorship.receiver = @mentee

          MentorshipMailer.should_receive(:deliver_rejected_mentorship_to_mentor).with(@mentorship).and_return(true)

          after_update
        end
        it "should send an email to the mentee if the mentee is the original sender" do
          @mentorship.sender = @mentee
          @mentorship.receiver = @mentor

          MentorshipMailer.should_receive(:deliver_rejected_mentorship_to_mentee).with(@mentorship).and_return(true)

          after_update
        end
      end      
    end # updated  
  end # life cycle
  
  describe "states" do
    before(:each) do
      @now = Time.now
      Time.stub!(:now).and_return(@now)      
    end
    describe "accepted" do
      it "should check to see if it has been accepted" do
        @mentorship.accepted_at = nil
        @mentorship.should_not be_accepted

        @mentorship.accepted_at = Time.now
        @mentorship.should be_accepted
      end
      it "should accept the mentorship and set the accepted_at time to now" do
        Time.should_receive(:now).and_return(@now)
      
        @mentorship.accept
        @mentorship.accepted_at.should == @now
      end
      it "should accept the mentorship and set the accepted_at time to a time passed in" do
        @then = "2008-10-13".to_time
      
        Time.should_not_receive(:now).and_return
      
        @mentorship.accept(@then)
        @mentorship.accepted_at.should == @then
      end
      it "should allow the accepted_at attribute to be set by passing a 1 (http param for true) into an accepted method" do
        @mentorship.accepted = "1"
        @mentorship.accepted_at.should == @now
      end
      it "should allow the accepted_at attribute to be cleared by passing a 0 (http param for true) into an accepted method" do
        @mentorship.accepted = "0"
        @mentorship.accepted_at.should == nil
      end
    end # accepted
    describe "rejected" do
      it "should check to see if it has been rejected" do
        @mentorship.rejected_at = nil
        @mentorship.should_not be_rejected

        @mentorship.rejected_at = Time.now
        @mentorship.should be_rejected
      end
      it "should accept the mentorship and set the rejected_at time to now" do
        Time.should_receive(:now).and_return(@now)
      
        @mentorship.reject
        @mentorship.rejected_at.should == @now
      end
      it "should accept the mentorship and set the rejected_at time to a time passed in" do
        @then = "2008-10-13".to_time
      
        Time.should_not_receive(:now).and_return
      
        @mentorship.reject(@then)
        @mentorship.rejected_at.should == @then
      end
      it "should allow the rejected_at attribute to be set by passing a 1 (http param for true) into an rejected method" do
        @mentorship.rejected = "1"
        @mentorship.rejected_at.should == @now
      end
      it "should allow the rejected_at attribute to be cleared by passing a 0 (http param for true) into an rejected method" do
        @mentorship.rejected = "0"
        @mentorship.rejected_at.should == nil
      end      
    end # rejected
    describe "completed" do
      it "should check to see if it has been completed" do
        @mentorship.completed_at = nil
        @mentorship.should_not be_completed

        @mentorship.completed_at = Time.now
        @mentorship.should be_completed
      end
      it "should accept the mentorship and set the completed_at time to now" do
        Time.should_receive(:now).and_return(@now)
      
        @mentorship.complete
        @mentorship.completed_at.should == @now
      end
      it "should accept the mentorship and set the completed_at time to a time passed in" do
        @then = "2008-10-13".to_time
      
        Time.should_not_receive(:now).and_return
      
        @mentorship.complete(@then)
        @mentorship.completed_at.should == @then
      end
      it "should allow the completed_at attribute to be set by passing a 1 (http param for true) into an completed method" do
        @mentorship.completed = "1"
        @mentorship.completed_at.should == @now
      end
      it "should allow the completed_at attribute to be cleared by passing a 0 (http param for true) into an completed method" do
        @mentorship.completed = "0"
        @mentorship.completed_at.should == nil
      end      
    end # completed    
  end # state 
  

  
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
    it "should have mentorship skills" do
      @mentorship.should respond_to("mentorship_skills") 
    end
    it "should have skills (through mentorship_skills)" do
      @mentorship.should respond_to("skills")
    end
    
  end # associations
  
  describe "skills" do
    before(:each) do
      @s1 = mock_model(Skill, :name => "Ruby")
      @s2 = mock_model(Skill, :name => "Java")
      @s3 = mock_model(Skill, :name => ".NET")
      @s4 = mock_model(Skill, :name => "PHP" )
      
      @mentor = mock_model(User)
      @mentee = mock_model(User)
      
      @mentorship.stub!(:mentor).and_return(@mentor)
      @mentorship.stub!(:mentee).and_return(@mentee)

      @us1 = mock_model(UserSkill, :skill => @s1, :skill_id => @s1.id, :level => 6)
      @us2 = mock_model(UserSkill, :skill => @s2, :skill_id => @s2.id, :level => 3)
      @us3 = mock_model(UserSkill, :skill => @s3, :skill_id => @s3.id, :level => 3)
      @mentor.stub!(:user_skills).and_return([@us1, @us2, @us3])
      
      @us4 = mock_model(UserSkill, :skill => @s1, :skill_id => @s1.id, :level => 1)
      @us5 = mock_model(UserSkill, :skill => @s2, :skill_id => @s2.id, :level => 3)
      @us6 = mock_model(UserSkill, :skill => @s3, :skill_id => @s3.id, :level => 5)
      @mentee.stub!(:user_skills).and_return([@us4, @us5, @us6])
    end
    
    describe "matched skills" do
      it "should get the matched skills" do
        @mentee.user_skills.each do |us|
          UserSkill.should_receive(:find_by_user_id_and_skill_id).with(@mentee.id, us.skill_id).and_return(us)
        end
        
        @mentorship.matched_skills.should == [{:skill => @s1, :mentor_user_skill => @us1, :mentee_user_skill => @us4},
                                               {:skill => @s2, :mentor_user_skill => @us2, :mentee_user_skill => @us5},
                                               {:skill => @s3, :mentor_user_skill => @us3, :mentee_user_skill => @us6},]
      end
    end # matched user skills
    
    describe "suggested skills" do
      it "should suggest skills where the mentor is better than/equal to the mentee" do
        @mentee.user_skills.each do |us|
          UserSkill.should_receive(:find_by_user_id_and_skill_id).with(@mentee.id, us.skill_id).and_return(us)
        end
        
        @mentorship.suggested_skills.should == [@s1, @s2]
      end
    end # suggesting skills
    
    describe "selected skills" do
      it "should get the skills and user levels that have been selected" do
        @ms1 = mock_model(MentorshipSkill, :skill => @s1, :mentorship => @mentorship, :skill_id => @s1.id)
        @mentorship.stub!(:mentorship_skills).and_return([@ms1])
        
        UserSkill.should_receive(:find_by_user_id_and_skill_id).with(@mentor.id, @s1.id).and_return(@us1)
        UserSkill.should_receive(:find_by_user_id_and_skill_id).with(@mentee.id, @s1.id).and_return(@us4)
        
        @mentorship.selected_skills.should == [{:skill => @s1, :mentor_user_skill => @us1, :mentee_user_skill => @us4}]
      end
    end
  end # skills
end
