class Mentorship < ActiveRecord::Base

  belongs_to :mentor, :class_name => "User"
  belongs_to :mentee, :class_name => "User"
  belongs_to :sender, :class_name => "User"
  belongs_to :receiver, :class_name => "User"

end
