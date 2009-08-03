require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

# Be sure to include AuthenticatedTestHelper in spec/spec_helper.rb instead.
# Then, you can remove it from this and the functional test.
include AuthenticatedTestHelper

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
      :available_to_be_mentored => false,
      :login => 'markmcspadden@gmail.com',
      :email => 'markmcspadden@gmail.com',
      :password => 'abcdef',
      :password_confirmation => 'abcdef'
    }
    
    @user = User.new(@valid_attributes)
  end

  it "should create a new instance given valid attributes" do
    @user.should be_valid
  end
  it "should give the name as the to_s method" do
    @user.to_s.should == "value for name"
  end
  
  describe "associations" do
    it "should have user_skills" do
      @user.should respond_to("user_skills")
    end
    it "should have skills (through user_skills)" do
      @user.should respond_to("skills")
    end
  end # associations
  

  
  describe "user skills and skills by level" do
    before(:each) do
      @s0 = mock_model(Skill)
      @s1 = mock_model(Skill)
      @s2 = mock_model(Skill)
      
      @us0 = mock_model(UserSkill, :skill => @s0, :level => 0)
      @us1 = mock_model(UserSkill, :skill => @s1, :level => 1)
      @us2 = mock_model(UserSkill, :skill => @s2, :level => 2)
      
      @user.stub!(:user_skills).and_return([@us0, @us1, @us2])
      @user.stub!(:skills).and_return([@s0, @s1, @s2])
    end 
    it "should find the user skills by level" do
      @user.user_skills_by_level(0).should == [@us0]
      @user.user_skills_by_level(1).should == [@us1]
      @user.user_skills_by_level(2).should == [@us2]
    end   
    it "should find the skills by level" do
      @user.skills_by_level(0).should == [@s0]
      @user.skills_by_level(1).should == [@s1]
      @user.skills_by_level(2).should == [@s2]
    end
  end # skills (by level)

  describe "restful authentication" do
    fixtures :users
    
    describe 'being created' do
      before do
        @user = nil
        @creating_user = lambda do
          @user = create_user
          violated "#{@user.errors.full_messages.to_sentence}" if @user.new_record?
        end
      end

      it 'increments User#count' do
        @creating_user.should change(User, :count).by(1)
      end
    end
    
    
    #
    # Validations
    #

    # LOGIN IS HANDLED BY EMAIL
    # it 'requires login' do
    #   lambda do
    #     u = create_user(:login => nil)
    #     u.errors.on(:login).should_not be_nil
    #   end.should_not change(User, :count)
    # end
    # 
    # describe 'allows legitimate logins:' do
    #   ['123', '1234567890_234567890_234567890_234567890',
    #    'hello.-_there@funnychar.com'].each do |login_str|
    #     it "'#{login_str}'" do
    #       lambda do
    #         u = create_user(:login => login_str)
    #         u.errors.on(:login).should     be_nil
    #       end.should change(User, :count).by(1)
    #     end
    #   end
    # end
    # describe 'disallows illegitimate logins:' do
    #   ['12', '1234567890_234567890_234567890_234567890_', "tab\t", "newline\n",
    #    "Iñtërnâtiônàlizætiøn hasn't happened to ruby 1.8 yet",
    #    'semicolon;', 'quote"', 'tick\'', 'backtick`', 'percent%', 'plus+', 'space '].each do |login_str|
    #     it "'#{login_str}'" do
    #       lambda do
    #         u = create_user(:login => login_str)
    #         u.errors.on(:login).should_not be_nil
    #       end.should_not change(User, :count)
    #     end
    #   end
    # end

    it 'requires password' do
      lambda do
        u = create_user(:password => nil)
        u.errors.on(:password).should_not be_nil
      end.should_not change(User, :count)
    end

    it 'requires password confirmation' do
      lambda do
        u = create_user(:password_confirmation => nil)
        u.errors.on(:password_confirmation).should_not be_nil
      end.should_not change(User, :count)
    end

    it 'requires email' do
      lambda do
        u = create_user(:email => nil)
        u.errors.on(:email).should_not be_nil
      end.should_not change(User, :count)
    end

    describe 'allows legitimate emails:' do
      ['foo@bar.com', 'foo@newskool-tld.museum', 'foo@twoletter-tld.de', 'foo@nonexistant-tld.qq',
       'r@a.wk', '1234567890-234567890-234567890-234567890-234567890-234567890-234567890-234567890-234567890@gmail.com',
       'hello.-_there@funnychar.com', 'uucp%addr@gmail.com', 'hello+routing-str@gmail.com',
       'domain@can.haz.many.sub.doma.in', 'student.name@university.edu'
      ].each do |email_str|
        it "'#{email_str}'" do
          lambda do
            u = create_user(:email => email_str)
            puts u.errors.full_messages
            u.errors.on(:email).should     be_nil
          end.should change(User, :count).by(1)
        end
      end
    end
    describe 'disallows illegitimate emails' do
      ['!!@nobadchars.com', 'foo@no-rep-dots..com', 'foo@badtld.xxx', 'foo@toolongtld.abcdefg',
       'Iñtërnâtiônàlizætiøn@hasnt.happened.to.email', 'need.domain.and.tld@de', "tab\t", "newline\n",
       'r@.wk', '1234567890-234567890-234567890-234567890-234567890-234567890-234567890-234567890-234567890@gmail2.com',
       # these are technically allowed but not seen in practice:
       'uucp!addr@gmail.com', 'semicolon;@gmail.com', 'quote"@gmail.com', 'tick\'@gmail.com', 'backtick`@gmail.com', 'space @gmail.com', 'bracket<@gmail.com', 'bracket>@gmail.com'
      ].each do |email_str|
        it "'#{email_str}'" do
          lambda do
            u = create_user(:email => email_str)
            u.errors.on(:email).should_not be_nil
          end.should_not change(User, :count)
        end
      end
    end

    it 'requires name' do
      lambda do
        u = create_user(:name => nil)
        u.errors.on(:name).should_not be_nil
      end.should_not change(User, :count)
    end
    describe 'allows legitimate names:' do
      ['Andre The Giant (7\'4", 520 lb.) -- has a posse',
       '1234567890_234567890_234567890_234567890_234567890_234567890_234567890_234567890_234567890_234567890',
      ].each do |name_str|
        it "'#{name_str}'" do
          lambda do
            u = create_user(:name => name_str)
            u.errors.on(:name).should     be_nil
          end.should change(User, :count).by(1)
        end
      end
    end
    describe "disallows illegitimate names" do
      ["tab\t", "newline\n",
       '','1234567890_234567890_234567890_234567890_234567890_234567890_234567890_234567890_234567890_234567890_',
       ].each do |name_str|
        it "'#{name_str}'" do
          lambda do
            u = create_user(:name => name_str)
            u.errors.on(:name).should_not be_nil
          end.should_not change(User, :count)
        end
      end
    end
    
    it "should set the login from the email" do
      u = create_user(:email => "markmcspadden@gmail.com", :login => nil)
      u.errors.on(:login).should be_nil
      u.login.should == "markmcspadden@gmail.com"
    end

    it 'resets password' do
      users(:quentin).update_attributes(:password => 'new password', :password_confirmation => 'new password')
      User.authenticate('quentin', 'new password').should == users(:quentin)
    end

    it 'does not rehash password' do
      puts users(:quentin)
      puts users(:quentin).update_attributes(:login => 'quentin2')
      
      users(:quentin).update_attributes(:login => 'quentin2')
      User.authenticate('quentin2', 'monkey').should == users(:quentin)
    end

    #
    # Authentication
    #

    it 'authenticates user' do
      User.authenticate('quentin', 'monkey').should == users(:quentin)
    end

    it "doesn't authenticate user with bad password" do
      User.authenticate('quentin', 'invalid_password').should be_nil
    end  
    it "doesn't authenticate a user against a hard-coded old-style password" do
      User.authenticate('old_password_holder', 'test').should be_nil
    end

    # New installs should bump this up and set REST_AUTH_DIGEST_STRETCHES to give a 10ms encrypt time or so
    desired_encryption_expensiveness_ms = 0.1
    it "takes longer than #{desired_encryption_expensiveness_ms}ms to encrypt a password" do
      test_reps = 100
      start_time = Time.now; test_reps.times{ User.authenticate('quentin', 'monkey'+rand.to_s) }; end_time   = Time.now
      auth_time_ms = 1000 * (end_time - start_time)/test_reps
      auth_time_ms.should > desired_encryption_expensiveness_ms
    end  

    #
    # Authentication
    #

    it 'sets remember token' do
      users(:quentin).remember_me
      users(:quentin).remember_token.should_not be_nil
      users(:quentin).remember_token_expires_at.should_not be_nil
    end

    it 'unsets remember token' do
      users(:quentin).remember_me
      users(:quentin).remember_token.should_not be_nil
      users(:quentin).forget_me
      users(:quentin).remember_token.should be_nil
    end

    it 'remembers me for one week' do
      before = 1.week.from_now.utc
      users(:quentin).remember_me_for 1.week
      after = 1.week.from_now.utc
      users(:quentin).remember_token.should_not be_nil
      users(:quentin).remember_token_expires_at.should_not be_nil
      users(:quentin).remember_token_expires_at.between?(before, after).should be_true
    end

    it 'remembers me until one week' do
      time = 1.week.from_now.utc
      users(:quentin).remember_me_until time
      users(:quentin).remember_token.should_not be_nil
      users(:quentin).remember_token_expires_at.should_not be_nil
      users(:quentin).remember_token_expires_at.should == time
    end

    it 'remembers me default two weeks' do
      before = 2.weeks.from_now.utc
      users(:quentin).remember_me
      after = 2.weeks.from_now.utc
      users(:quentin).remember_token.should_not be_nil
      users(:quentin).remember_token_expires_at.should_not be_nil
      users(:quentin).remember_token_expires_at.between?(before, after).should be_true
    end
    
    protected
      def create_user(options = {})
        record = User.new({ :login => 'quire', :email => 'quire@example.com', :password => 'quire69', :password_confirmation => 'quire69', :name => "quire" }.merge(options))
        record.save
        record
      end
    
  end # restful authentication
  
  describe "availability" do
    describe "mentoring status" do
      it "should try and get the current_mentoring_mentorship" do
        Mentorship.should_receive(:find).with(:first, :conditions => ["mentor_id = ? AND accepted_at IS NOT NULL AND completed_at IS NULL", @user.id])
        
        @user.current_mentoring_mentorship
      end
      it "should get the current apprentice from the current mentoring mentorship" do
        @u2 = mock_model(User)
        @user.stub!(:current_mentoring_mentorship).and_return(mock_model(Mentorship, :mentee => @u2))
        @user.current_apprentice.should == @u2
      end
      it "should have the current apprentice as nil if a current mentoring mentorship doesn't exist" do
        @user.stub!(:current_mentoring_mentorship).and_return(nil)
        @user.current_apprentice.should be_nil
      end
      it "should show that the user is currently mentoring if there is a current mentoring mentorship" do
        @user.stub!(:current_mentoring_mentorship).and_return(mock_model(Mentorship))
        @user.should be_currently_mentoring
      end
      it "should return nil if there is not a mentorship found" do
        @user.stub!(:current_mentoring_mentorship).and_return(nil)
        @user.should_not be_currently_mentoring
      end
    end # mentoring status
    
    describe "apprenticing status" do
      it "should try and get the current apprenticing mentorship" do
        Mentorship.should_receive(:find).with(:first, :conditions => ["mentee_id = ? AND accepted_at IS NOT NULL AND completed_at IS NULL", @user.id])
        
        @user.current_apprenticing_mentorship
      end
      it "should get the current mentor from the current apprenticing mentorship" do
        @u2 = mock_model(User)
        @user.stub!(:current_apprenticing_mentorship).and_return(mock_model(Mentorship, :mentor => @u2))
        @user.current_mentor.should == @u2
      end
      it "should have the current mentor as nil if a current apprenticing mentorship doesn't exist" do
        @user.stub!(:current_apprenticing_mentorship).and_return(nil)
        @user.current_mentor.should be_nil
      end
      it "should show that the user is currently apprenticing if there is a current apprenticing mentorship" do
        @user.stub!(:current_apprenticing_mentorship).and_return(mock_model(Mentorship))
        @user.should be_currently_apprenticing
      end
      it "should return nil if there is not a mentorship found" do
        @user.stub!(:current_apprenticing_mentorship).and_return(nil)
        @user.should_not be_currently_apprenticing
      end
    end # apprenticing status
    
    describe "remote" do
      it "should combine hours and increments for remote_availability" do
        @user.remote_availability_hours = "2"
        @user.remote_availability_increment = "week"
        @user.remote_availability.should == "2 hours per week"
      end
      it "should give a nil remote_availability if remote_availability_hours are 0" do
        @user.remote_availability_hours = 0
        @user.remote_availability_increment = "week"
        @user.remote_availability.should == nil
      end    
      it "should get the hours and increment from the remote_availbility" do
        @user.remote_availability = "3 hours per month"
        @user.remote_availability_hours.should == 3
        @user.remote_availability_increment.should == "month"
      end
      it "should get the hours and increment from the remote_availbility even if remote_avaiability is blank" do
        @user.remote_availability = nil
        @user.remote_availability_hours.should == 0
        @user.remote_availability_increment.should == nil
      end
    end # remote

    describe "local" do
      it "should combine hours and increments for local_availability" do
        @user.local_availability_hours = "2"
        @user.local_availability_increment = "week"
        @user.local_availability.should == "2 hours per week"
      end
      it "should give a nil local_availability if local_availability_hours are 0" do
        @user.local_availability_hours = 0
        @user.local_availability_increment = "week"
        @user.local_availability.should == nil
      end      
      it "should get the hours and increment from the local_availbility" do
        @user.local_availability = "3 hours per month"
        @user.local_availability_hours.should == 3
        @user.local_availability_increment.should == "month"
      end
      it "should get the hours and increment from the local_availbility even if local_avaiability is blank" do
        @user.local_availability = nil
        @user.local_availability_hours.should == 0
        @user.local_availability_increment.should == nil
      end
    end # local

    it "should have availability hours" do
      User.availability_hours.should == [0,1,2,3,4,5,6,7,8,9,10]
    end
    it "should have availability increments" do
      User.availability_increments.should == ["day", "week", "month"]
    end
  end # availability

  describe "singleton methods" do
    # NOTE: There is a plugin for this 
    # If it starts being used alot in other places it'd probably be a good idea to look into
    # http://github.com/mshiltonj/active_record_random_find/tree/master
    it "should get a random user" do
      @ids = [{"id"=>"1"}, {"id"=>"2"}, {"id"=>"3"}, 
              {"id"=>"4"}, {"id"=>"5"}, {"id"=>"6"},
              {"id"=>"7"}, {"id"=>"8"}, {"id"=>"9"}]
      
      User.connection.should_receive(:select_all).with("SELECT id FROM users").and_return(@ids)
      
      # TODO: Mock out the rand function
      # It's kind of hard to get it to return different values each time
      # 6.times do |i|
      #   User.should_receive(:rand).and_return(i)
      # end
      
      User.should_receive(:find) #.with([1,2,3]) # Once the rand is mocked we can add the 'with'
      
      User.random(3)
    end
    
    describe "search" do
      def do_search(q="ruby")
        User.search(q)
      end
      
      it "should return an empty array if the search term is blank or nil" do
        do_search("").should == []
        do_search(nil).should == []
      end
      
      it "should look for name match" do
        User.should_receive(:find).with(:all, :conditions => ["name LIKE ?", "%ruby%"])
        do_search
      end
      
      it "should look for a skills match and find users associated to that skill" do
        @s1 = mock_model(Skill, :id => 12)
        @skills = [@s1]
        
        Skill.should_receive(:find).with(:all, :conditions => ["name LIKE ?", "%ruby%"]).and_return(@skills)
        UserSkill.should_receive(:find).with(:all, 
                                              :conditions => ["skill_id IN (?)", @skills.collect{ |s| s.id }],
                                              :include => [:user]).and_return([])
        
        do_search
      end
    end
  end # singleton methods

end

