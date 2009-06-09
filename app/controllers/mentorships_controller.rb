class MentorshipsController < ApplicationController
  # GET /mentorships
  # GET /mentorships.xml
  def index
    @mentorships = Mentorship.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @mentorships }
    end
  end

  # GET /mentorships/1
  # GET /mentorships/1.xml
  def show
    @mentorship = Mentorship.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @mentorship }
    end
  end

  # GET /mentorships/new
  # GET /mentorships/new.xml
  def new
    
    # Get mentor and mentee via params + current user
    # Get sender and receiver based on current user and mentor/mentee params
    if params[:mentor_id]
      @mentor = User.find(params[:mentor_id])
      @mentee = current_user
      @sender = current_user
      @receiver = @mentor
    elsif params[:mentee_id]
      @mentor = current_user
      @mentee = User.find(params[:mentee_id])
      @sender = current_user
      @receiver = @mentee
    else
      redirect_to mentorships_path and return false
    end
    
    # Actually create the Mentorship object
    @mentorship = Mentorship.new( :mentor => @mentor,
                                  :mentee => @mentee,
                                  :sender => @sender,
                                  :receiver => @receiver )
    


    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @mentorship }
    end
  end

  # GET /mentorships/1/edit
  def edit
    @mentorship = Mentorship.find(params[:id])
  end

  # POST /mentorships
  # POST /mentorships.xml
  def create    
    @mentorship = Mentorship.new(params[:mentorship])
    
    # REFACTOR: This probably belongs in the model
    # Instead of having a separate params[:skills] should just have params[:mentorship][:skills]
    # And handle all this skill setting in the model.
    skills = []
    params[:skills].keys.each do |skill_id|
      skill = Skill.find(skill_id)
      skills << skill
    end
    @mentorship.skills = skills

    respond_to do |format|
      if @mentorship.save
        flash[:notice] = 'Mentorship was successfully created.'
        format.html { redirect_to(@mentorship) }
        format.xml  { render :xml => @mentorship, :status => :created, :location => @mentorship }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @mentorship.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /mentorships/1
  # PUT /mentorships/1.xml
  def update
    @mentorship = Mentorship.find(params[:id])

    respond_to do |format|
      if @mentorship.update_attributes(params[:mentorship])
        flash[:notice] = 'Mentorship was successfully updated.'
        format.html { redirect_to(@mentorship) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @mentorship.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /mentorships/1
  # DELETE /mentorships/1.xml
  def destroy
    @mentorship = Mentorship.find(params[:id])
    @mentorship.destroy

    respond_to do |format|
      format.html { redirect_to(mentorships_url) }
      format.xml  { head :ok }
    end
  end
  
  # GET /mentorships/1/response
  def respond
    
  end
end
