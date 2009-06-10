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


  protected
    # NOT CURRENTLY IN USE
    # def password_authentication(name, password)
    #   if @current_user = @account.users.authenticate(params[:name], params[:password])
    #     successful_login
    #   else
    #     failed_login "Sorry, that username/password doesn't work"
    #   end
    # end

    def open_id_authentication
      authenticate_with_open_id do |result, identity_url|
        if result.successful?
          if @current_user = User.find_by_identity_url(identity_url)
            successful_login
          else
            failed_login "Sorry, no user by that identity URL exists (#{identity_url})"
          end
        else
          failed_login result.message
        end
      end
    end
  
  
  private
    def successful_login
      session[:user_id] = @current_user.id
      redirect_to(root_url)
    end

    def failed_login(message)
      flash[:error] = message
      redirect_to(new_session_url)
    end


end
