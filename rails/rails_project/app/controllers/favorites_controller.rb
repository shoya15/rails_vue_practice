class FavoritesController < ApplicationController
  def index
    if !current_user
      render_success error: "loading_error"
    else
      @favorites = current_user.favorites

      favorites = []
      @favorites.each{ favorites << _1.task_id }
      render_success favorites: favorites
    end
  end

  def create
    @task = Task.find_by(id: params[:task_id])
    @favorite = Favorite.new(user_id: current_user.id, task_id: @task.id)
    render_success favorite_task: @favorite.task_id if @favorite.save
  end

  def destroy
    @task = Task.find_by(id: params[:id])
    @favorite = Favorite.find_by(task_id: @task.id)
    render_success task: @favorite if @favorite.destroy
  end
end
