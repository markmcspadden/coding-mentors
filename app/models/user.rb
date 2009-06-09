class User < ActiveRecord::Base

  has_many :user_skills
  has_many :skills, :through => :user_skills

  def to_s
    "#{name}"
  end
  
  def user_skills_by_level(level)
    user_skills.select{ |us| us.level == level.to_i }
  end
  def skills_by_level(level)
    user_skills_by_level(level).collect{ |us| us.skill }
  end

end
