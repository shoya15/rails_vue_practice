class RelationshipsController < ApplicationController
  def index
    if !current_user
      render_success error: "loading_error"
    else
      @users = current_user.relationships.ids
      # 配列でなく連想配列の形にして飛ばす必要がある
      render_success followings: @users
    end
  end

  def create
    # followed_idは、current_userのidで固定されてしまう -> idで渡すことにした
    @following = current_user.relationships.new(id: relationship_params[:followed_id])
    # pp @following
    render_success followed_id: relationship_params[:followed_id] if @following.save
  end

  def destroy
    @unfollow = current_user.relationships.find_by(id: params[:id])
    render_success user: @unfollow if @unfollow.destroy
  end

  private

  def relationship_params
    params.require(:relationship).permit(:followed_id)
  end
end
