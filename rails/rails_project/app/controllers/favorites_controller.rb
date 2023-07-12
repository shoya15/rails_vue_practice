class FavoritesController < ApplicationController
  def index
    @favorites = current_user.favorites.map(&:task_id)
    render_success favorites: @favorites
  end

  def create
    @task     = Task.find_by(id: params[:task_id])
    @favorite = Favorite.new(user_id: current_user.id, task_id: @task.id)
    render_success favorite_task: @favorite if @favorite.save
  end

  def destroy
    @task     = Task.find_by(id: params[:id])
    @favorite = Favorite.find_by(task_id: @task.id)
    render_success task: @favorite if @favorite.destroy
  end
end
