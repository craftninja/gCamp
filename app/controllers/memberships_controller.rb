class MembershipsController < ApplicationController
  before_action :verify_user

  def index
    @project = Project.find(params[:project_id])
  end

end
