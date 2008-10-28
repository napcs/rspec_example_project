class ProjectsController < ApplicationController
  before_filter :login_required
  
  def index
    @projects = Project.latest_five
  end
  
  def new
    @project = Project.new
  end
  
  def create
    @project = Project.new(params[:project])
    if @project.save
      redirect_to projects_url
    else
      render :action => "new"
    end
  end
end
