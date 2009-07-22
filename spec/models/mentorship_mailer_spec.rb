require File.expand_path(File.dirname(__FILE__) + '/../mailer_helper')

describe MentorshipMailer do
  FIXTURES_PATH = File.dirname(__FILE__) + '/../fixtures'
  CHARSET = 'utf-8'

  include MailerSpecHelper
  include ActionMailer::Quoting

  before(:each) do
    setup_tmail
    
    @sender = mock_model(User, :email => "sender@email.com", :name => "Mark McSpadden")
    @receiver = mock_model(User, :email => "receiver@email.com", :name => "Dave Kruse")
    
    @s1 = mock_model(Skill, :name => "Ruby on Rails")
    @s2 = mock_model(Skill, :name => "Ruby")
    @s3 = mock_model(Skill, :name => "Metaprogramming")
    
    @mentorship = mock_model(Mentorship, :mentor => @receiver, 
                                          :mentee => @sender, 
                                          :sender => @sender, 
                                          :receiver => @receiver,
                                          :skills => [@s1, @s2, @s3])
    @mentorship.stub!(:to_param).and_return("1")
  end
  
  it "should send a new mentorship email to the mentor" do
    @expected.subject = 'Mark McSpadden would like to be mentored by you!'
    @expected.bcc     = 'Coding Mentors <support@codingmentors.com>'
    @expected.from    = 'Coding Mentors <system@codingmentors.com>'
    @expected.to      = @receiver.email
    @expected.body    = read_fixture('new_mentorship_to_mentor')
    
    MentorshipMailer.create_new_mentorship_to_mentor(@mentorship).encoded.should == @expected.encoded      
  end
  
  def setup_tmail
    # You don't need these lines while you are using create_ instead of deliver_
    ActionMailer::Base.delivery_method = :test
    ActionMailer::Base.perform_deliveries = true
    ActionMailer::Base.deliveries = []

    @expected = TMail::Mail.new
    @expected.set_content_type 'text', 'html', { 'charset' => CHARSET }
    @expected.mime_version = '1.0'
  end
  
end