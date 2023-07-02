class TasksController < ApplicationController
  before_action :find_task, only: [:show, :destroy]
  
  def index
    @tasks = Task.all
    # .order(created_at: :desc)
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
        status: task_params[:status]
      }
    else
      render_error
    end
  end

  def destroy
    @post.destroy if current_user?
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
