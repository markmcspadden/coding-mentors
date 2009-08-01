class MentorshipMailer < ActionMailer::Base

  # Setup host options
  default_url_options[:host] =  if Rails.env.test?
                                  "www.test.loc"
                                else
                                  "www.codingmentors.com"
                                end

  def new_mentorship_to_mentor(mentorship)
    setup_email
    
    @receiver = mentorship.receiver
    @sender = mentorship.sender
    
    @skills = mentorship.skills.collect{ |s| s.name }.to_sentence
    @mentorship = mentorship

    @recipients = @receiver.email
    @subject = "#{@sender.name} would like to be mentored by you!"
  end
  
  def accepted_mentorship_to_mentee(mentorship)
    setup_email
    
    @receiver = mentorship.mentee
    @sender = mentorship.mentor
    
    @skills = mentorship.skills.collect{ |s| s.name }.to_sentence
    @mentorship = mentorship    
    
    @recipients = @receiver.email
    @subject = "#{@sender.name} has agreed to mentor you!"    
  end
  
  def accepted_mentorship_to_mentor(mentorship)
    setup_email
    
    @receiver = mentorship.mentor
    @sender = mentorship.mentee
    
    @skills = mentorship.skills.collect{ |s| s.name }.to_sentence
    @mentorship = mentorship    
    
    @recipients = @receiver.email
    @subject = "#{@sender.name} has agreed to be your apprentice!"    
  end  
  
  protected
  def setup_email
    @from = system_email
    @bcc = support_email
    @content_type = "text/html"
  end
  
  def system_email
    "Coding Mentors <system@codingmentors.com>"
  end
  def support_email
    "Coding Mentors <support@codingmentors.com>"
  end

end
