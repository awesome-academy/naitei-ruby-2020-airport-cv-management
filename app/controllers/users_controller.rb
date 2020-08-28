class UsersController < ApplicationController
  def new
    @user = User.new
    @user.build_profile
  end

  def create
    @user = User.new candidate_params
    if @user.save
      @user.send_activation_email
      flash[:success] = t ".success"
      flash[:info] = t ".email_sent"
      redirect_to root_path
    else
      flash[:error] = t ".error"
      render :new
    end
  end

  private

  def candidate_params
    params.require(:user).permit User::USER_PARAMS
  end
end
