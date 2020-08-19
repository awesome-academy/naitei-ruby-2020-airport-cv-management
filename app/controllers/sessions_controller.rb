class SessionsController < ApplicationController
  def new; end

  def create
    user = User.find_by email: params[:session][:email]
    if user&.authenticate(params[:session][:password])
      authenticate_handle user
    else
      flash[:error] = t "sessions.new.error_message"
      render :new
    end
  end

  private

  def authenticate_handle user
    log_in user
    params[:session][:remember_me] == Settings.user.checkbox_value ? remember(user) : forget(user)
    flash.clear
    redirect_to root_url
  end
end