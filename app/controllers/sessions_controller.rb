class SessionsController < ApplicationController
  before_action :require_login, only: [:show]
  
  def new
  end
  
  def show
    @memos = Memo.where(user_id: current_user.id).order("updated_at DESC")
  end
  
  def create
    user = User.find_by(id: params[:user_id])
    if user
      reset_session
      session[:user_id] = user.id
      redirect_to session_path, notice: "Logged in as " + user.name
    else
      redirect_to new_session_path, alert: "Login failed"
    end
  end
  
  def destroy
    reset_session
    redirect_to root_path, notice: "Logged out. Bye!"
  end
end