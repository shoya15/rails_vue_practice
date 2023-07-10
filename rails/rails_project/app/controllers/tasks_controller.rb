class TasksController < ApplicationController
  before_action :tasks, only: [:index, :favorites_count]
  
  def index
    render_success tasks: @tasks
  end

  def favorites_count
    favorites_count = {}
    @tasks.each{ favorites_count[_1.id] = _1.favorites.count }
    render_success favorites_count: favorites_count
  end

  def create
    @task = Task.new(task_params)
    @task.user = current_user
    if @task.save
      render_success task: {
        content: task_params[:content],
        status: task_params[:status],
        user_id: @task.user.id,
        user_name: @task.user.name,
        id: @task.id
      }
    end
  end

  def update
    @task = Task.find(params[:id])
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

  def tasks
    @tasks = Task.all
  end
end
