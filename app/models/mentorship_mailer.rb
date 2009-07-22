class MentorshipMailer < ActionMailer::Base

  # Setup host options
  default_url_options[:host] =  if Rails.env.test?
                                  "www.test.loc"
                                else
                                  "www.codingmentors.com"
                                end

  def new_mentorship_to_mentor(mentorship)
    @receiver = mentorship.receiver
    @sender = mentorship.sender
    
    @skills = mentorship.skills.collect{ |s| s.name }.to_sentence
    @mentorship = mentorship
    
    @from = system_email
    @recipients = @receiver.email
    @bcc = support_email
    @content_type = "text/html"
    
    @subject = "#{@sender.name} would like to be mentored by you!"
  end
  
  protected
  def system_email
    "Coding Mentors <system@codingmentors.com>"
  end
  def support_email
    "Coding Mentors <support@codingmentors.com>"
  end

end
