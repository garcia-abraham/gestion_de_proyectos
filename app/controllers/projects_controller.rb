class ProjectsController < ApplicationController

  before_action :authenticate_user!
  before_action :admin_user, :except => [:index]
  before_action :correct_user, :except => [:index, :new, :create]

  def index
    @user = current_user
    case params[:filter].to_i
    when 0
      @projects = @user.projects.sort_by(&:total_price).reverse!
    when 1
      @projects = @user.projects.sort_by(&:total_members).reverse!
    when 2
      @projects = @user.projects.sort_by(&:average_percentage).reverse!
    else
      @projects = @user.projects
    end
  end

  def new
    @project = Project.new
  end

  def create
    @project = Project.new(project_params)
    if @project.save && GroupProject.create(user_id: current_user.id, project_id: @project.id, role: :administrator)
      flash[:success] = "Proyecto Creado"
      redirect_to root_path
    else
      flash.now[:alert] = @project.errors.full_messages.join("\n")
      render 'new'
    end
  end

  def edit
    @project = Project.find(params[:id])
  end

  def update
    @project = Project.find(params[:id])
    if @project.update_attributes(project_params)
      flash[:success] = "Proyecto Editado"
      redirect_to root_path
    else
      flash.now[:alert] = @project.errors.full_messages.join("\n")
      render 'edit'
    end
  end

  def destroy
    Project.find(params[:id]).destroy
    flash[:success] = "Proyecto Borrado"
    redirect_to root_path
  end

  private

  def project_params
    params.require(:project).permit(:name, :detail, :start_date, :finish_date, :status)
  end

  def correct_user
    @project = current_user.projects.find_by(id: params[:id])
    redirect_to root_url if @project.nil?
  end

end
