class UserSkill < ActiveRecord::Base
  
  belongs_to :user
  belongs_to :skill
  
  def skill_name
    skill ? skill.name : nil
  end
  def skill_name=(new_value)
    # OPTIMIZE: I believe indexing the name column of skills won't do any good here
    # However, on sqlite3, search are very case sensitive so this matters
    existing_skill = Skill.find(:first, :conditions => ["LOWER(name) = LOWER(?)", new_value])
    
    if !existing_skill
      existing_skill = Skill.create(:name => new_value)
    end
    
    self.skill_id = existing_skill.id
  end
  
end
