class UsersController < ApplicationController
  
  def new
    @user = User.new
    render :new
  end
  
  def index
    @users = User.all
  end
  
  def show
    @user = User.find(params[:id])
    render :show
  end
  

  def create
    @user = User.new(user_params)

    if @user.save
      flash[:notice] = ["Sign-Up Successful!"]
      login_user!(@user)
      redirect_to user_url(@user)
    else
      flash[:notice] = ["OH NO! Unable to Sign Up..."]
      render :new
    end
  end
  
  def user_params
    params.require(:user).permit(:email, :password)
  end
end
