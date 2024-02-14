class UsersController < ApplicationController 
  def new 
    @user = User.new
  end 

  def show 
    if current_user
      @user = User.find(params[:id])
    else
      flash[:error] = "You must be logged in or registered to access a user's dashboard."
      redirect_to root_path
    end
  end 

  def create 
    user = User.create(user_params)
    if user.save
      session[:user_id] = user.id
      flash[:success] = "Welcome, #{user.name}"
      redirect_to user_path(user)
    else  
      flash[:error] = user.errors.full_messages.to_sentence
      redirect_to register_path
    end 
  end 

  def login_form

  end 

  def login_user
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      cookies.encrypted[:location] = params[:location]
      flash[:success] = "Welcome, #{user.name}"
      redirect_to "/users/#{user.id}"
    else 
      flash[:error] = "Bad Credentials, try again."
      redirect_to "/login" 
    end 
  end 

  private 

  def user_params 
    params.require(:user).permit(:name, :email, :password)
  end 
end 