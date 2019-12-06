class ResourceTasksController < ApplicationController

  before_action :authenticate_user!
  before_action :correct_user, only: [:create, :index, :new]

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
      redirect_to  task_resource_tasks_path @task
    else
      flash.now[:alert] = @resources.errors.full_messages.join("\n")
      render 'new'
    end
  end

  def edit
    @resource = ResourceTask.find(params[:id])
  end

  def update
    @resource_task = ResourceTask.find(params[:id])
    @resource = Resource.find(params[:resource_task][:resource_id])
    params[:resource_task].merge!(total: @resource.price.to_i * params[:resource_task][:quantity].to_i)
    if @resource_task.update_attributes(resource_params)
      flash[:success] = "Recurso Editado"
      redirect_to task_resource_tasks_path @resource_task.task
    else
      flash.now[:alert] = @resource_task.errors.full_messages.join("\n")
      render 'edit'
    end
  end

  def destroy
    @resource = ResourceTask.find(params[:id])
    @resource.destroy
    flash[:success] = "Recurso Borrado"
    redirect_back(fallback_location: root_path)
  end

  private

  def resource_params
    params.require(:resource_task).permit(:resource_id, :quantity, :total)
  end

  def correct_user
    @project = current_user.projects.find_by(id: Task.find(params[:task_id]).project)
    redirect_to root_url if @project.nil?
  end

end
