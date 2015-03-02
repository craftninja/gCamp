class TasksController < ApplicationController
  before_action :verify_user
  before_action :set_project

  def index
    @tasks = @project.tasks
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    if @task.save
      flash[:success] = 'Task was successfully created'
      redirect_to project_task_path(@project, @task)
    else
      render :new
    end
  end

  def show
    @task = Task.find(params[:id])
  end

  def edit
    @task = Task.find(params[:id])
  end

  def update
    @task = Task.find(params[:id])
    if @task.update(task_params)
      flash[:success] = 'Task was successfully updated'
      redirect_to project_task_path(@project, @task)
    else
      render :edit
    end
  end

  def destroy
    @task = Task.find(params[:id])
    @task.destroy
    redirect_to project_tasks_path(@project)
  end

  private

  def task_params
    params.require(:task).permit(:description, :completed, :due_date).merge(:project_id => @project.id)
  end

  def set_project
    @project = Project.find(params[:project_id])
  end

end
