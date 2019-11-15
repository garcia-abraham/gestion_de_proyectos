class GroupProjectsController < ApplicationController

  before_action :authenticate_user!
  before_action :admin_user

  def index
    @project = Project.find(params[:project_id])
    @group_projects = @project.group_projects
  end

  def new
    @project = Project.find(params[:project_id])
    @group_project = GroupProject.new(role: :collaborator)
  end

  def create
    @project = Project.find(params[:project_id])
    @group_project = GroupProject.new(group_project_params)
    if @group_project.save
      flash[:success] = "Miembro Agregado"
      redirect_to project_group_projects_path @project
    else
      flash.now[:alert] = @group_project.errors.full_messages.join("\n")
      render 'new'
    end

  end

  def destroy
    GroupProject.find(params[:id]).destroy
    flash[:success] = "Miembro Eliminado"
    redirect_back(fallback_location: root_path)
  end

  private

  def group_project_params
    params.require(:group_project).permit(:user_id, :project_id, :role)
  end

end
