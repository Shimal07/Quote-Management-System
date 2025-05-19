class ApplicationController < ActionController::Base
    helper_method :current_user, :logged_in?, :is_administrator?
    def current_user
        @current_user ||= User.find_by(id: session[:user_id])
    end

    def logged_in?
        !current_user.nil?
    end

    def is_administrator?
        session[:is_admin]
    end
private
def require_login
    unless logged_in?
    flash[:error] = "You are not permitted to access this resource"
    redirect_to login_path
    end 
    end
   
end
