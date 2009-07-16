class Skill < ActiveRecord::Base

  has_many :user_skills
  has_many :users, :through => :user_skills
  
  def to_s
    "#{name}"
  end
  
  class << self
    
    def levels
      [ [1, "Innocent", "I know it exists"],
        [2, "Exposed", "I know I need it"],
        [3, "Apprentice", "I've tried it with supervision"],
        [4, "Practitioner", "I've been trained and used it a few times"],
        [5, "Journeyman", "I've got this down"], 
        [6, "Master", "I know this inside and outside"],
        [7, "Researcher", "I'm working on improving or extending the skill itself"] ]
    end

  end

end
