class Skill < ActiveRecord::Base

  has_many :user_skills
  has_many :users, :through => :user_skills
  
  def to_s
    "#{name}"
  end

end
