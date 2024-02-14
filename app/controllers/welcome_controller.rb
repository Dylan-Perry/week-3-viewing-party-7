class WelcomeController < ApplicationController 
  def index 
    @users = User.all
    if params[:log_out] == "true"
      cookies.delete :_week3_viewing_party7_session
    end
  end 
end 