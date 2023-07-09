class UsersController < ApplicationController
  def create
    # これを書かないとユーザー登録されない(インスタンスの生成)
    @user = User.new(user_params)
    if @user.save
      render_success user: {
        name: user_params[:name],
        email: user_params[:email],
        password: user_params[:password],
        password_confirmation: user_params[:password_confirmation],
      }
    end
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
