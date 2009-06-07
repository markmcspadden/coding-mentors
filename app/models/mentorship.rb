class Mentorship < ActiveRecord::Base

  belongs_to :mentor, :class_name => "User"
  belongs_to :mentee, :class_name => "User"
  belongs_to :sender, :class_name => "User"
  belongs_to :receiver, :class_name => "User"

  # Setup States based on xxx_at attributes
  # I know acts_as_state exists, I just wanted to role my own to see how close it would match
  # EXAMPLE
  # def accepted?
  #   !self.accepted_at.nil?
  # end
  # def accept(new_value = nil)
  #   if new_value.is_a?(DateTime) || new_value.is_a?(Date) || new_value.is_a?(Time)
  #     self.accepted_at = new_value
  #   else
  #     self.accepted_at = Time.now
  #   end
  # end
  # def accepted=(zero_or_one)
  #   zero_or_one_i = zero_or_one.to_i
  #   
  #   if zero_or_one_i == 0
  #     self.accepted_at = nil
  #   elsif zero_or_one_i == 1
  #     self.accepted_at = Time.now
  #   end
  # end
  states = [ ["accept", "accepted"], 
              ["reject", "rejected"], 
              ["complete", "completed"] ]
              
  states.each do |state|
    attribute = "#{state[1]}_at"
    define_method("#{state[0]}") do |new_value|
      if new_value.is_a?(DateTime) || new_value.is_a?(Date) || new_value.is_a?(Time)
        self.send("#{attribute}=", new_value)
      else
        self.send("#{attribute}=", Time.now)
      end      
    end
    
    define_method("#{state[1]}?") do
      !self.send("#{attribute}").nil?
    end
    
    define_method("#{state[1]}=") do |zero_or_one|
      zero_or_one_i = zero_or_one.to_i

      if zero_or_one_i == 0
        self.send("#{attribute}=", nil)
      elsif zero_or_one_i == 1
        self.send("#{attribute}=", Time.now)
      end      
    end
  end

end




















