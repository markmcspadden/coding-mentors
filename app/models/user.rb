require 'digest/sha1'

class User < ActiveRecord::Base
  
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
  
  # TODO: MetaProgram these
  # Remote availability
  def remote_availability_hours
    @remote_availability_hours ||= remote_availability.split(" hours per ").first.to_i
  end
  def remote_availability_increment
    @remote_availability_increment ||= remote_availability.split(" hours per ").last
  end  
  def remote_availability_hours=(new_value)
    @remote_availability_hours = new_value
    self.remote_availability = "#{remote_availability_hours} hours per #{remote_availability_increment}"
    @remote_availability_hours
  end
  def remote_availability_increment=(new_value)
    @remote_availability_increment = new_value
    self.remote_availability = "#{remote_availability_hours} hours per #{remote_availability_increment}"
    @remote_availability_increment
  end  
  
  # Local availability
  def local_availability_hours
    @local_availability_hours ||= local_availability.split(" hours per ").first.to_i
  end
  def local_availability_increment
    @local_availability_increment ||= local_availability.split(" hours per ").last
  end  
  def local_availability_hours=(new_value)
    @local_availability_hours = new_value
    self.local_availability = "#{local_availability_hours} hours per #{local_availability_increment}"
    @local_availability_hours
  end
  def local_availability_increment=(new_value)
    @local_availability_increment = new_value
    self.local_availability = "#{local_availability_hours} hours per #{local_availability_increment}"
    @local_availability_increment
  end  
  
  class << self
    
    def availability_hours
      (1..10).to_a
    end
    def availability_increments
      ["day", "week", "month"]
    end
    
  end

end
