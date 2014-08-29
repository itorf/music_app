class SessionsController < ApplicationController
  
  def create
    user = User.find_by_credentials(
      params[:user][:email],
      params[:user][:password]
      )
      
    if user 
      login_user!(user)
      redirect_to user_url(user)
    else
      flash[:notice] = ["Incorrect Email/Password combination"]
      render :new
    end
  end
  
  def new
    render :new
  end
  
  def destroy
    user = current_user
    logout!(user)
    redirect_to new_session_url
  end
end
