class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_user

  def current_user
    @current_user ||= User.find_by(:id => session[:current_user_id])
  end

  def verify_user
    if !current_user
      flash[:error] = 'You must sign in'
      redirect_to signin_path
    end
  end

  def verify_membership
    if !current_user.member?(@project)
      flash[:error] = 'You do not have access to that project'
      redirect_to projects_path
    end
  end

end
