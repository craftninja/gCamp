class MembershipsController < ApplicationController
  before_action :verify_user

  def index
    @project = Project.find(params[:project_id])
    @membership = Membership.new
  end

  def create
    @project = Project.find(params[:project_id])
    @membership = @project.memberships.new(membership_params)
    if @membership.save
      flash[:notice] = "#{@membership.user.full_name} was successfully added"
      redirect_to project_memberships_path(@project)
    else
      render :index
    end
  end

  private

  def membership_params
    params.require(:membership).permit(:user_id, :role)
  end

end
