class Skill < ActiveRecord::Base

  has_many :user_skills
  has_many :users, :through => :user_skills
  
  def to_s
    "#{name}"
  end
  
  class << self
    
    def levels
      [ ["Innocent", 1],
        ["Exposed", 2],
        ["Apprentice", 3],
        ["Practitioner", 4],
        ["Journeyman", 5],
        ["Master", 6],
        ["Researcher", 7] ]      
    end
    
    def level_descriptions
      {"Innocent" => "I know it exists", 
       "Exposed" => "I know I need it",
       "Apprentice" => "I've tried it with supervision",
       "Practitioner" => "I've been trained and used it a few times",
       "Journeyman" => "I've got this down",
       "Master" => "I know this inside and outside",
       "Researcher" => "I'm working on improving the skill itself"}
    end
    
  end

end
