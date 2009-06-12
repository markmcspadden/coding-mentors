class UserSkillsController < ApplicationController
  # GET /user_skills
  # GET /user_skills.xml
  def index
    @user_skills = UserSkill.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @user_skills }
    end
  end

  # GET /user_skills/1
  # GET /user_skills/1.xml
  def show
    @user_skill = UserSkill.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @user_skill }
    end
  end

  # GET /user_skills/new
  # GET /user_skills/new.xml
  def new
    @user_skill = UserSkill.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @user_skill }
    end
  end

  # GET /user_skills/1/edit
  def edit
    @user_skill = UserSkill.find(params[:id])
  end

  # POST /user_skills
  # POST /user_skills.xml
  def create    
    @user_skill = UserSkill.new(params[:user_skill])

    respond_to do |format|
      if @user_skill.save
        # flash[:notice] = 'UserSkill was successfully created.'
        format.html { redirect_to(@user_skill) }
        format.js {
          # render :update do |page|
          #   page.alert "Skill was added successfully"
          # end
          render :partial => "skills", :locals => {:level => @user_skill.level, :user => @user_skill.user}
        }
        format.xml  { render :xml => @user_skill, :status => :created, :location => @user_skill }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @user_skill.errors, :status => :unprocessable_entity }
        format.js {
          render :partial => "skills", :locals => {:level => @user_skill.level, :user => @user_skill.user, :errors => @user_skill.errors.full_messages}
        }        
      end
    end
  end

  # PUT /user_skills/1
  # PUT /user_skills/1.xml
  def update
    @user_skill = UserSkill.find(params[:id])

    respond_to do |format|
      if @user_skill.update_attributes(params[:user_skill])
        flash[:notice] = 'UserSkill was successfully updated.'
        format.html { redirect_to(@user_skill) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @user_skill.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /user_skills/1
  # DELETE /user_skills/1.xml
  def destroy
    @user_skill = UserSkill.find(params[:id])
    @user_skill.destroy

    respond_to do |format|
      format.html { redirect_to(user_skills_url) }
      format.xml  { head :ok }
    end
  end
end
