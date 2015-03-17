class MembershipsController < ApplicationController
  before_action :verify_user
  before_action :set_project
  before_action :set_membership, only: [:update, :destroy]
  before_action :verify_owner, only: [:create, :update]
  before_action :verify_self_or_owner, only: [:destroy]
  before_action :verify_other_owners, only: [:update, :destroy]

  def index
    @membership = Membership.new
  end

  def create
    @membership = @project.memberships.new(membership_params)
    if @membership.save
      flash[:notice] = "#{@membership.user.full_name} was successfully added"
      redirect_to project_memberships_path(@project)
    else
      render :index
    end
  end

  def update
    if @membership.update(membership_params)
      flash[:notice] = "#{@membership.user.full_name} was successfully updated"
      redirect_to project_memberships_path(@project)
    else
      render :index
    end
  end

  def destroy
    @membership.destroy
    flash[:notice] = "#{@membership.user.full_name} was successfully removed"
    if current_user == @membership.user
      redirect_to projects_path
    else
      redirect_to project_memberships_path(@project)
    end
  end

  private

  def membership_params
    params.require(:membership).permit(:user_id, :role)
  end

  def set_project
    @project = Project.find(params[:project_id])
  end

  def set_membership
    @membership = Membership.find(params[:id])
  end

  def verify_other_owners
    if @membership.role == 'owner' && @project.memberships.where(:role => 1).length <= 1
      flash[:error] = 'Projects must have at least one owner'
      redirect_to project_memberships_path(@project)
    end
  end

end
