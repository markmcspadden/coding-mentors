class Mentorship < ActiveRecord::Base
  ### AUTHORIZATION
  include Authorization::Mentorship::InstanceMethods
  extend Authorization::Mentorship::SingletonMethods

  belongs_to :mentor, :class_name => "User"
  belongs_to :mentee, :class_name => "User"
  belongs_to :sender, :class_name => "User"
  belongs_to :receiver, :class_name => "User"
  
  has_many :mentorship_skills
  has_many :skills, :through => :mentorship_skills
  
  # LIFECYCLE  
  def after_create
    if self.sender == self.mentee
      MentorshipMailer.deliver_new_mentorship_to_mentor(self)
    end
    if self.sender == self.mentor
      MentorshipMailer.deliver_new_mentorship_to_mentee(self)
    end
  end
  
  def after_update
    if self.accepted?
      MentorshipMailer.deliver_accepted_mentorship_to_mentee(self)
      MentorshipMailer.deliver_accepted_mentorship_to_mentor(self)      
    end
    
    if self.rejected?
      if self.sender == self.mentee
        MentorshipMailer.deliver_rejected_mentorship_to_mentee(self)        
      end
      if self.sender == self.mentor
        MentorshipMailer.deliver_rejected_mentorship_to_mentor(self)
      end
    end
  end

  # Setup States based on xxx_at attributes
  # I know acts_as_state exists, I just wanted to role my own to see how close it would match
  # EXAMPLE
  # def accepted?
  #   !self.accepted_at.nil?
  # end
  # def accept(new_value = nil)
  #   if new_value.is_a?(DateTime) || new_value.is_a?(Date) || new_value.is_a?(Time)
  #     self.accepted_at = new_value
  #   else
  #     self.accepted_at = Time.now
  #   end
  # end
  # def accepted=(zero_or_one)
  #   zero_or_one_i = zero_or_one.to_i
  #   
  #   if zero_or_one_i == 0
  #     self.accepted_at = nil
  #   elsif zero_or_one_i == 1
  #     self.accepted_at = Time.now
  #   end
  # end
  states = [ ["accept", "accepted"], 
              ["reject", "rejected"], 
              ["complete", "completed"] ]
              
  states.each do |state|
    attribute = "#{state[1]}_at"
    define_method("#{state[0]}") do |new_value|
      if new_value.is_a?(DateTime) || new_value.is_a?(Date) || new_value.is_a?(Time)
        self.send("#{attribute}=", new_value)
      else
        self.send("#{attribute}=", Time.now)
      end      
    end
    
    define_method("#{state[1]}?") do
      !self.send("#{attribute}").nil?
    end
    
    define_method("#{state[1]}=") do |zero_or_one|
      zero_or_one_i = zero_or_one.to_i

      if zero_or_one_i == 0
        self.send("#{attribute}=", nil)
      elsif zero_or_one_i == 1
        self.send("#{attribute}=", Time.now)
      end      
    end
  end
  
  # SKILLS
  
  # OPTIMIZE: This is just going to pound the mess out of the db
  # Number of queries is n+1 wher n is the number of skills the mentor has  
  def matched_skills
    ms = []
    
    mentor.user_skills.select do |us|
      comparable = UserSkill.find_by_user_id_and_skill_id(mentee.id, us.skill_id)
      if comparable
        ms << {:skill => us.skill, :mentor_user_skill => us, :mentee_user_skill => comparable}
      end
    end
    
    ms
  end
  
  def suggested_skills
    suggested_matched_skills = matched_skills.select do |ms|
                              ms[:mentor_user_skill].level >= ms[:mentee_user_skill].level
                            end
    suggested_matched_skills.collect{ |ms| ms[:skill] }
  end
  
  def selected_skills
    ss = []
    
    mentorship_skills.each do |ms|
      mentor_user_skill = UserSkill.find_by_user_id_and_skill_id(mentor.id, ms.skill_id)
      mentee_user_skill = UserSkill.find_by_user_id_and_skill_id(mentee.id, ms.skill_id)

      ss << {:skill => ms.skill, :mentor_user_skill => mentor_user_skill, :mentee_user_skill => mentee_user_skill}
    end
    
    ss    
  end

end




















