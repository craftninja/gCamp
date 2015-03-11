class ProjectsController < ApplicationController
  before_action :verify_user

  def index
    @projects = Project.all
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
    @project = Project.find(params[:id])
  end

  def edit
    @project = Project.find(params[:id])
  end

  def update
    @project = Project.find(params[:id])
    if @project.update(project_params)
      flash[:success] = 'Project was successfully updated'
      redirect_to project_path(@project)
    else
      render :edit
    end
  end

  def destroy
    @project = Project.find(params[:id])
    @project.destroy
    flash[:success] = 'Project was successfully deleted'
    redirect_to projects_path
  end

  private

  def project_params
    params.require(:project).permit(:name)
  end

end
