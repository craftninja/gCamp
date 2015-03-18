class ProjectsController < ApplicationController
  before_action :set_project, except: [:index, :new, :create]
  before_action :verify_membership_or_admin, except: [:index, :new, :create]
  before_action :verify_owner_or_admin, only: [:edit, :update, :destroy]

  def index
    if current_user.admin
      @projects = Project.all
    else
      @projects = current_user.projects
    end
  end

  def new
    @project = Project.new
  end

  def create
    @project = Project.new(project_params)
    if @project.save
      Membership.create!(
        :project_id => @project.id,
        :user_id => @current_user.id,
        :role => :owner
      )
      flash[:success] = 'Project was successful created'
      redirect_to project_tasks_path(@project)
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @project.update(project_params)
      flash[:success] = 'Project was successfully updated'
      redirect_to project_path(@project)
    else
      render :edit
    end
  end

  def destroy
    @project.destroy
    flash[:success] = 'Project was successfully deleted'
    redirect_to projects_path
  end

  private

  def project_params
    params.require(:project).permit(:name)
  end

  def set_project
    @project = Project.find(params[:id])
  end

end
