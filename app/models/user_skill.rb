class UserSkill < ActiveRecord::Base
  
  belongs_to :user
  belongs_to :skill
  
  # VALIDATIONS
  validates_uniqueness_of :skill_id, :scope => :user_id, :message => "has already be assigned by you"
  
  # TODO: after_save update the cooresponding user text fields
  # This will probably used for better faster indexing
  # But for now it's on the back burner
  # user.master_skills
  # user.intermediate_skills
  # user.newbie_skills
  
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
