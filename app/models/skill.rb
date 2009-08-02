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
    
    # TODO: This is replicated in User. One more and it's plugin time.
    def random(limit=1)
      # Get all the ids
      ids = connection.select_all("SELECT id FROM #{table_name}")
      
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

  end

end
