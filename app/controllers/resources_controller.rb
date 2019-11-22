class ResourcesController < ApplicationController

  before_action :authenticate_user!
  before_action :correct_user, only: [:create, :index, :new]
  before_action :correct_resource, only: [:edit, :update, :destroy]

  def index
    @task = Task.find(params[:task_id])
    @resources = @task.resources_tasks
  end

  def new
    @resources = Resource.all# este hace la busqueda
  end

  def create
    @task = Task.find(params[:task_id])
    @resource = Resource.find(params[:resource_id])
    quantity = params[:quantity]
    total = @resource.price * quantity.to_i
    @resource_task = ResourceTask.create task: @task, resource: @resource, quantity: quantity, total: total
    if @resource_task.save
      flash[:success] = "Recurso Agregado"
      redirect_to  task_resources_path @task
    else
      flash.now[:alert] = @resources.errors.full_messages.join("\n")
      render 'new'
    end
  end

  def edit
    @resource = Resource.find(params[:id])
  end

  def update
    @resource = Resource.find(params[:id])
    if @resource.update_attributes(resource_params)
      flash[:success] = "Recurso Editado"
      redirect_to task_resources_path @resource.task
    else
      flash.now[:alert] = @project.errors.full_messages.join("\n")
      render 'edit'
    end
  end

  def destroy
    @resource = current_user.tasks.resources_tasks.find(params[:id])
    @resource.destroy
    flash[:success] = "Recurso Borrado"
    redirect_back(fallback_location: root_path)
  end

  private

  def resource_params
    params.require(:resource).permit(:name, :quantity, :price)
  end

  def correct_user
    @project = current_user.projects.find_by(id: Task.find(params[:task_id]).project)
    redirect_to root_url if @project.nil?
  end

  def correct_resource
    @task = current_user.tasks.find_by(id: Resource.find(params[:id]).task)
    redirect_to root_url if @task.nil?
  end

end
