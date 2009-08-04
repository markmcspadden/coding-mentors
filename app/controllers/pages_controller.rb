class PagesController < ApplicationController
  skip_before_filter :login_required
  
  # GET /
  def home    
    # Get some random users to display
    @users = User.random(2)
    
    # Get some random skills to display
    @skills = Skill.random(2)
  end
  
  # GET /search
  def search
    @users = User.search(params[:q])
  end
  
  # GET /guides
  def guides
    
  end
  
  # GET /about
  def about
    
  end
  
  # GET /error
  def error
    
  end
  
  # GET /denied
  def denied
    
  end

  

end
