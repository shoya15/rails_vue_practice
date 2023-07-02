class SessionsController < ApplicationController
  def create
    user = User.find_by(name: session_params[:name_or_email]) || User.find_by(email: session_params[:name_or_email])
    if user && user.authenticate(session_params[:password])
      log_in user
      render_success session: {
        name_or_email: session_params[:name_or_email],
        password: session_params[:password]
      }
    else
      render_error
    end
  end

  def destroy
    log_out if logged_in?
  end

  private

  def session_params
    params.require(:session).permit(
      :name_or_email,
      :password
    )
  end
end
