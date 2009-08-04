class PagesController < ApplicationController
  skip_before_filter :login_required
  
  # GET /
  def home    
    # Get some random users to display
    @users = User.random(2)
    
    # Get some random skills to display
    @skills = Skill.random(2)
    
    if current_user
      outstandings = current_user.mentorships_to_respond_to
      if !outstandings.empty?
        flash[:notice] = <<-EOS
          You have requests awaiting your response:<br/>
          #{outstandings.collect{ |m| "<a href=\"#{respond_mentorship_path(m)}\">Respond</a>" }.join("<br/>")}
        EOS
      end
    end
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
