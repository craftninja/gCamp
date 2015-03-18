class CommentsController < ApplicationController

  def create
    task = Task.find(params[:task_id])
    comment = Comment.new(comments_params.merge(
      :task_id => task.id,
      :user_id => current_user.id
    ))
    comment.save
    redirect_to project_task_path(Project.find(task.project_id), task)
  end

  private

  def comments_params
    params.require(:comment).permit(:content)
  end

end
