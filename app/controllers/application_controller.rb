class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_user, :check_user, :logged_in?, :require_login, :require_user
  
  private
    def logged_in?
      current_user.present?
    end
    def check_user(uid)
      return logged_in? && current_user.id == uid
    end
    
    def require_login
      if !logged_in?
        redirect_to "/session/new", alert: "Login required!"
        return false;
      end
      return true;
    end
    
    def require_user(uid)
      if require_login && current_user.id != uid
        redirect_to "/session/new", alert: "You can't perform this. Please switch to correct account."
      end
    end
    
    def current_user
      if session[:user_id]
        @current_user ||= User.find(session[:user_id])
      end
    end
  
end
