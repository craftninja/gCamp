class ApplicationController < ActionController::Base
  before_action :verify_user
  protect_from_forgery with: :exception
  helper_method :current_user, :current_user_or_admin, :current_user_comember_or_admin

  def current_user
    @current_user ||= User.find_by(:id => session[:current_user_id])
  end

  def current_user_or_admin(user)
    user == current_user || current_user.admin
  end

  def current_user_comember_or_admin(user)
    comember = if current_user.projects.count > 0
      current_user.projects.each do |project|
        project.users.include?(user) ? (return true) : (return false)
      end
    end
    user == current_user || comember || current_user.admin
  end

  def verify_user
    if !current_user
      session[:request_path] = request.env['PATH_INFO']
      flash[:error] = 'You must sign in'
      redirect_to signin_path
    end
  end

  def verify_membership_or_admin
    unless current_user.admin || current_user.member?(@project)
      flash[:error] = 'You do not have access to that project'
      redirect_to projects_path
    end
  end

  def verify_owner_or_admin
    if !current_user.owner_or_admin?(@project)
      flash[:error] = 'You do not have access'
      redirect_to project_path(@project)
    end
  end

  def verify_self_or_owner_or_admin
    if !(current_user.owner_or_admin?(@project) || current_user == @membership.user)
      flash[:error] = 'You do not have access'
      redirect_to project_memberships_path(@project)
    end
  end

end
