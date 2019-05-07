class ApplicationController < ActionController::Base

    # C E L L L

    def current_user
        @current_user ||= User.find_by_session_token(session[:session_token])
    end

    def signed_in? 
        !!@current_user
    end

    def log_in(user)
        @current_user = user
        session[:session_token] = user.reset_session_token!
    end
    
    def log_out
        @current_user.try(:reset_session_token!)
        session[:session_token] = nil
    end

    def ensure_logged_in
        # current_user.session_token = session[:session_token]
        redirect_to new_session_url unless signed_in?
    end
end
