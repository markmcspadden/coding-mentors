require 'digest/sha1'

class User < ActiveRecord::Base
  ### AUTHORIZATION
  include Authorization::User::InstanceMethods
  extend Authorization::User::SingletonMethods
  
  ###
  ### RESTFUL AUTHENTICATION
  ###
  include Authentication
  include Authentication::ByPassword
  include Authentication::ByCookieToken

  # LOGIN SET BY EMAIL
  # validates_presence_of     :login
  # validates_length_of       :login,    :within => 3..40
  # validates_uniqueness_of   :login
  # validates_format_of       :login,    :with => Authentication.login_regex, :message => Authentication.bad_login_message

  validates_presence_of     :name
  validates_format_of       :name,     :with => Authentication.name_regex,  :message => Authentication.bad_name_message
  validates_length_of       :name,     :maximum => 100

  validates_presence_of     :email
  validates_length_of       :email,    :within => 6..100 #r@a.wk
  validates_uniqueness_of   :email
  validates_format_of       :email,    :with => Authentication.email_regex, :message => Authentication.bad_email_message

  # HACK HACK HACK -- how to do attr_accessible from here?
  # prevents a user from submitting a crafted form that bypasses activation
  # anything else you want your user to change should be added here.
  attr_accessible :login, :email, :name, :password, :password_confirmation,
                  :remote_availability, :remote_availability_hours, :remote_availability_increment,
                  :local_availability, :local_availability_hours, :local_availability_increment,
                  :available_to_mentor, :available_to_be_mentored
  
  # Authenticates a user by their login name and unencrypted password.  Returns the user or nil.
  #
  # uff.  this is really an authorization, not authentication routine.  
  # We really need a Dispatch Chain here or something.
  # This will also let us return a human error message.
  #
  def self.authenticate(login, password)
    return nil if login.blank? || password.blank?
    u = find_by_login(login.downcase) # need to get the salt
    u && u.authenticated?(password) ? u : nil
  end

  def login=(value)
    write_attribute :login, (value ? value.downcase : nil)
  end

  def email=(value)
    write_attribute :login, (value ? value.downcase : nil)
    write_attribute :email, (value ? value.downcase : nil)
  end
  ###
  ### END RESTFUL AUTHENTICATION
  ###

  # ASSOCIATIONS
  has_many :user_skills, :order => "level DESC"
  has_many :skills, :through => :user_skills

  # ADD GRAVATAR SUPPORT
  is_gravtastic


  def to_s
    "#{name}"
  end
  
  def user_skills_by_level(level)
    user_skills.select{ |us| us.level == level.to_i }
  end
  def skills_by_level(level)
    user_skills_by_level(level).collect{ |us| us.skill }
  end
  
  ###
  ### Mentorships
  ###
  def mentorships_to_respond_to
    Mentorship.find(:all, :conditions => ["receiver_id = ? AND accepted_at IS NULL AND rejected_at IS NULL", self.id])    
  end
  
  # Mentoring status
  def current_mentoring_mentorship
    Mentorship.find(:first, :conditions => ["mentor_id = ? AND accepted_at IS NOT NULL AND completed_at IS NULL", self.id])
  end
  def current_apprentice
    current_mentoring_mentorship.mentee if current_mentoring_mentorship
  end
  def currently_mentoring?
    current_mentoring_mentorship ? true : false
  end
  
  # Apprenticing status
  def current_apprenticing_mentorship
    Mentorship.find(:first, :conditions => ["mentee_id = ? AND accepted_at IS NOT NULL AND completed_at IS NULL", self.id])
  end
  def current_mentor
    current_apprenticing_mentorship.mentor if current_apprenticing_mentorship
  end
  def currently_apprenticing?
    current_apprenticing_mentorship ? true : false
  end
  
  # Availability is text based at this time
  # I figure it will morph and change quite a bit at the beginning
  # However, I still wanted user dropdowns to give a good jumping off point
  # to choose your availability
  # So, I created these methods that morph input from 2 drops downs
  # (xxx_availability_hours and xxx_availability_increment) in the text field
  # And we need them for both remote and local...a great opportunity to Meta Program
  # Whenever these become more stable, let's do just that.
  
  # TODO: Convert to metaprogrammed methods
  # Remote availability
  def remote_availability_hours
    @remote_availability_hours ||= remote_availability.to_s.split(" hours per ").first.to_i
  end
  def remote_availability_increment
    @remote_availability_increment ||= remote_availability.to_s.split(" hours per ").last
  end  
  def remote_availability_hours=(new_value)
    @remote_availability_hours = new_value
    self.remote_availability = set_remote_availability
    @remote_availability_hours
  end
  def remote_availability_increment=(new_value)
    @remote_availability_increment = new_value
    self.remote_availability = set_remote_availability
    @remote_availability_increment
  end
  def derived_remote_availability
    set_remote_availability
  end 
  def set_remote_availability
    if remote_availability_hours == 0
      nil
    else
      "#{remote_availability_hours} hours per #{remote_availability_increment}"
    end
  end 
  
  # Local availability
  def local_availability_hours
    @local_availability_hours ||= local_availability.to_s.split(" hours per ").first.to_i
  end
  def local_availability_increment
    @local_availability_increment ||= local_availability.to_s.split(" hours per ").last
  end  
  def local_availability_hours=(new_value)
    @local_availability_hours = new_value
    self.local_availability = set_local_availability
    @local_availability_hours
  end
  def local_availability_increment=(new_value)
    @local_availability_increment = new_value
    self.local_availability = set_local_availability
    @local_availability_increment
  end 
  def derived_local_availability
    set_local_availability
  end
  def set_local_availability
    if local_availability_hours == 0
      nil
    else
      "#{local_availability_hours} hours per #{local_availability_increment}"
    end
  end   
  
  class << self
    
    def availability_hours
      (0..10).to_a
    end
    def availability_increments
      ["day", "week", "month"]
    end

    # TODO: This is replicated in Skill. One more and it's plugin time.
    def random(limit=1)
      # Get all the ids
      ids = connection.select_all("SELECT id FROM #{table_name}")
      
      # Return [] if ids are empty
      return [] if ids.empty?
      
      # Get 'limit' number of random ids
      # Actually double the limit in case there are any duplicates
      random_ids = []
      (limit.to_i * 2).times do
        random_ids << ids[rand(ids.size)]["id"].to_i
      end
      
      # Get uniq entries and cut the random_ids down to size
      random_ids = random_ids.uniq[0..limit-1]
      
      # Now look up those users
      find(random_ids)
    end
    
    # TODO: This obviously need to be handled by a full-text search index
    # Thinking-Sphinx is a personal fav and it will probably be coming soon
    def search(q)
      return [] if q.blank?
      
      q = "%#{q}%"
      
      results = []
      
      # Look for name matches
      results << User.find(:all, :conditions => ["name LIKE ?", q])
      
      # Look for skill matches
      skills = Skill.find(:all, :conditions => ["name LIKE ?", q])
      results << UserSkill.find(:all, :conditions => ["skill_id IN (?)", skills.collect{ |s| s.id }], :include => [:user]).collect{ |us| us.user }

      results.flatten.compact.uniq
    end
  end

end
