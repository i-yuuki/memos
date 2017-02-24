class SessionsController < ApplicationController
  def new
  end
  
  def create
    user = User.find_by(id: params[:user_id])
    if user
      reset_session
      session[:user_id] = user.id
      redirect_to root_path, notice: "Logged in as " + user.name
    else
      redirect_to root_path, alert: "Login failed"
    end
  end
  
  def destroy
    reset_session
    redirect_to root_path, notice: "Logged out. Bye!"
  end
end