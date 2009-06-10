class SessionsController < ApplicationController

  # COPIED FROM rails-open_id_authentication plugin README
  # TODO: This need specs!!!
  def create
    if using_open_id?
      open_id_authentication
    else
      # NOT CURRENTLY IN USE
      # password_authentication(params[:name], params[:password])
      flash[:error] = "Username/Password authentication is not supported.<br/><br/>How did you get here?"
      redirect_to new_session_url
    end
  end
  
  def signup
    open_id_signup(params[:user])
  end
  
  def destroy
    cookies.delete :auth_token
    reset_session
    flash[:notice] = "You have been logged out."
    redirect_to('/')
  end


  protected
    # NOT CURRENTLY IN USE
    # def password_authentication(name, password)
    #   if @current_user = @account.users.authenticate(params[:name], params[:password])
    #     successful_login
    #   else
    #     failed_login "Sorry, that username/password doesn't work"
    #   end
    # end

    # BARE BONES (NO INFO PASSING)
    def open_id_authentication
      authenticate_with_open_id do |result, identity_url|        
        if result.successful?
          if @current_user = User.find_by_identity_url(identity_url)
            successful_login
          else
            failed_login_with_signup_option "Sorry, no user by that identity URL exists (#{identity_url})<br/>Would you like to Sign Up?"
          end
        else
          failed_login result.message
        end
      end
    end
    
    def open_id_signup(options = {})
      
      # Setup blank user options if not passed in
      # options[:user] = options[:user] ? options[:user] : {}
      
      authenticate_with_open_id(nil, :required => ["email", "http://axschema.org/contact/email", "http://schema.openid.net/contact/email", "http://openid.net/schema/contact/email"]) do |result, identity_url, registration|        
        if result.successful?
          user = User.new(:identity_url => identity_url)#, :email => options[:user][:email], :name => options[:user][:name])
            
          @current_user = user  
           assign_registration_attributes!(registration)         
                    
          if @current_user.save
            
            successful_signup
          else
            failed_signup "There was a problem with creating an account for you based on your OpenId registration details. There is probably something wrong on our end :/"
          end
        else
          failed_signup result.message
        end
      end
    end
    
    # registration is a hash containing the valid sreg keys given above
    # use this to map them to fields of your user model
    def assign_registration_attributes!(registration)
      puts registration
      y registration
      model_to_registration_mapping.each do |model_attribute, registration_attribute|
        unless registration[registration_attribute].blank?
          @current_user.send("#{model_attribute}=", registration[registration_attribute])
        end
      end
    end

    def model_to_registration_mapping
      { :name => 'nickname', :email => 'email', :name => 'fullname' }
    end

    # ADVANCED
    # ONLY WORKS WITH *SOME* OPENID PROVIDERS
    # DOES NOT WORK WITH BLOGSPOT
    # def open_id_authentication(identity_url)
    #   # Pass optional :required and :optional keys to specify what sreg fields you want.
    #   # Be sure to yield registration, a third argument in the #authenticate_with_open_id block.
    #   authenticate_with_open_id(identity_url, 
    #       :required => [ :nickname, :email ],
    #       :optional => :fullname) do |result, identity_url, registration|
    #     case result.status
    #     when :missing
    #       failed_login "Sorry, the OpenID server couldn't be found"
    #     when :invalid
    #       failed_login "Sorry, but this does not appear to be a valid OpenID"
    #     when :canceled
    #       failed_login "OpenID verification was canceled"
    #     when :failed
    #       failed_login "Sorry, the OpenID verification failed"
    #     when :successful
    #       if @current_user = @account.users.find_by_identity_url(identity_url)
    #         assign_registration_attributes!(registration)
    # 
    #         if current_user.save
    #           successful_login
    #         else
    #           failed_login "Your OpenID profile registration failed: " +
    #             @current_user.errors.full_messages.to_sentence
    #         end
    #       else
    #         failed_login "Sorry, no user by that identity URL exists"
    #       end
    #     end
    #   end
    # end
  
  
  private
    def successful_login
      session[:user_id] = @current_user.id
      redirect_to(root_url)
    end
    
    def successful_signup
      flash[:notice] = "SignUp successful!"
      session[:user_id] = @current_user.id
      redirect_to(user_path(@current_user))
    end

    def failed_login(message)
      flash[:error] = message
      redirect_to(new_session_url)
    end
    
    def failed_login_with_signup_option(message)
      flash[:error] = message
      redirect_to(signup_users_url)      
    end
    
    def failed_signup(message)
      flash[:error] = message
      redirect_to(signup_users_url)
    end


end
