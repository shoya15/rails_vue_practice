class RelationshipsController < ApplicationController
  def index
    @followings = current_user.relationships.map(&:followed_id)
    render_success followings: @followings
  end

  def create
    @following = current_user.relationships.new(followed_id: relationship_params[:followed_id])
    render_success followed_id: relationship_params[:followed_id] if @following.save
  end

  def destroy
    @unfollow = current_user.relationships.find_by(followed_id: params[:id])
    render_success user: @unfollow if @unfollow.destroy
  end

  private

  def relationship_params
    params.require(:relationship).permit(:followed_id)
  end
end
