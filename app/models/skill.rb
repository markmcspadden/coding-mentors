class Skill < ActiveRecord::Base

  has_many :user_skills
  has_many :users, :through => :user_skills
  
  def to_s
    "#{name}"
  end
  
  class << self
    
    def levels
      [ ["Innocent", 1, "I know it exists"],
        ["Exposed", 2, "I know I need it"],
        ["Apprentice", 3, "I've tried it with supervision"],
        ["Practitioner", 4, "I've been trained and used it a few times"],
        ["Journeyman", 5, "I've got this down"], 
        ["Master", 6, "I know this inside and outside"],
        ["Researcher", 7, "I'm working on improving or extending the skill itself"] ]
    end

  end

end
