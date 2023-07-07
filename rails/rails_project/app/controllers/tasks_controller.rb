class TasksController < ApplicationController
  before_action :find_task, only: [:show, :update]
  
  def index
    @tasks = Task.all
    render_success @tasks
  end

  def show
  end

  def create
    @task = Task.new(task_params)
    @task.user = current_user
    if @task.save
      render_success task: {
        content: task_params[:content],
        status: task_params[:status],
        user_id: @task.user.id,
        id: @task.id
      }
    else
      render_error
    end
  end

  def update
    @task.update(task_params)
    render_success task: {
      content: @task.content,
      status: true,
      user_id: @task.user_id,
      id: @task.id
    }
  end

  private

  def task_params
    params.require(:task).permit(
      :content,
      :status
    )
  end

  def find_task
    @task = Task.find(params[:id])
  end
end
