class TasksController < ApplicationController

  before_action :authenticate_user!
  before_action :correct_user, only: [:create, :index, :new]
  before_action :correct_task, only: [:destroy]
  before_action :correct_editor, only: [:edit, :update]

  def index
    @project = Project.find(params[:project_id])
    
    case params[:filter].to_i
    when 0
      @tasks = @project.tasks.sort_by(&:total_price).reverse!
    when 1
      @tasks = @project.tasks.sort_by(&:total_resources).reverse!
    else
      @tasks = @project.tasks
    end
  end

  def edit
    @task = Task.find(params[:id])
  end

  def new
    @project = Project.find(params[:project_id])
    @task = Task.new(project_id: @project.id)
  end

  def create
    @project = Project.find(params[:project_id])
    @task = current_user.tasks.new(task_params)
    if @task.save
      flash[:success] = "Tarea Creada"
      redirect_to project_tasks_path @project
    else
      flash.now[:alert] = @task.errors.full_messages.join("\n")
      render 'new'
    end
  end

  def update
    @task = Task.find(params[:id])
    if @task.update_attributes(task_params)
      flash[:success] = "Tarea Editada"
      redirect_to project_tasks_path @task.project
    else
      render 'edit'
    end
  end

  def destroy
    Task.find(params[:id]).destroy
    flash[:success] = "Tarea Borrada"
    redirect_back(fallback_location: root_path)
  end

  private

  def task_params
    params.require(:task).permit(:name, :detail, :percentage, :start_date, :finish_date, :status, :project_id)
  end

  def correct_user
    @project = current_user.projects.find_by(id: params[:project_id])
    redirect_to root_url if @project.nil?
  end

  def correct_editor
    @project = current_user.projects.find_by(id: Task.find(params[:id]).project)
    redirect_to root_url if @project.nil?
  end

  def correct_task
    @task = current_user.tasks.find_by(id: params[:id])
    redirect_to root_url if @task.nil?
  end




end
