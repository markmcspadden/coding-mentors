class Mentorship < ActiveRecord::Base

  belongs_to :mentor, :class_name => "User"
  belongs_to :mentee, :class_name => "User"
  belongs_to :sender, :class_name => "User"
  belongs_to :receiver, :class_name => "User"

  # TODO: Metaprogram this
  # states = [ ["accept", "accepted"], 
  #             ["reject", "rejected"], 
  #             ["complete", "completed"] ]
  # I know acts_as_state exists, I just wanted to role my own to see how close it would match
  def accepted?
    !self.accepted_at.nil?
  end
  def accept(new_value = nil)
    if new_value.is_a?(DateTime) || new_value.is_a?(Date) || new_value.is_a?(Time)
      self.accepted_at = new_value
    else
      self.accepted_at = Time.now
    end
  end
  def rejected?
    !self.rejected_at.nil?
  end
  def reject(new_value = nil)
    if new_value.is_a?(DateTime) || new_value.is_a?(Date) || new_value.is_a?(Time)
      self.rejected_at = new_value
    else
      self.rejected_at = Time.now
    end
  end
  def completed?
    !self.completed_at.nil?
  end
  def complete(new_value = nil)
    if new_value.is_a?(DateTime) || new_value.is_a?(Date) || new_value.is_a?(Time)
      self.completed_at = new_value
    else
      self.completed_at = Time.now
    end
  end  

end
