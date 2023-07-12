class SessionsController < ApplicationController
  def check_signed_in
    pp "hohogjfipajdfpjfpe"
    pp current_user
    pp "hfasdhaljjzkdsjzsid"
    render_success if current_user.nil?
  end

  def create
    @name_or_email = session_params[:name_or_email]
    @password = session_params[:password]
    @user = User.find_by(name:  @name_or_email) ||
            User.find_by(email: @name_or_email)

    if @user && @user.authenticate(@password)
     sign_in @user
      render_success session: {
        name_or_email: @name_or_email,
        password: @password,
        user_id:  session[:user_id]
      }
    end
  end

  def destroy
    if signed_in?
      sign_out
      render_success
    end
  end

  private

  def session_params
    params.require(:session).permit(
      :name_or_email,
      :password
    )
  end
end
