class MentorshipSkill < ActiveRecord::Base

  belongs_to :mentorship
  belongs_to :skill

end
