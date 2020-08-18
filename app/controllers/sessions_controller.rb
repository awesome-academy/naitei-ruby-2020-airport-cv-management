class SessionsController < ApplicationController

  def new
  end

  def create
    user = User.find_by name: params[:session][:name].downcase
    if user && user.authenticate(params[:session][:password])
      log_in user
      params[:session][:remember_me] == Settings.user.checkbox_value ? remember(user) : forget(user)
      redirect_to user
    else
      flash[:danger] = t "sessions.new.error_message"
      render :new
    end
  end

  def destroy
    log_out
    flash[:success] = "You are logged out"
    redirect_to login_path
  end
end
