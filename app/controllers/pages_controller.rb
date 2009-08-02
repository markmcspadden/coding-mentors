class PagesController < ApplicationController
  def home    
    # Get some random users to display
    @users = User.random(2)
    
    # Get some random skills to display
    @skills = Skill.random(2)
  end

end
