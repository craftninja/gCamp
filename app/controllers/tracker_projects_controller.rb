class TrackerProjectsController < ApplicationController

  def show
    @stories = PivotalTracker.new.get_stories(params[:id], current_user.pivotal_tracker_token)
    @project = params[:project_name]
  end

end
