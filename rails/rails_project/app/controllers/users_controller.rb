class UsersController < ApplicationController
  def create
    @user = User.new(user_params)
    render_success user: @user if @user.save
  end
  
  private

  def user_params
    params.require(:user).permit(
      :name,
      :email,
      :password,
      :password_confirmation
    )
  end
end
