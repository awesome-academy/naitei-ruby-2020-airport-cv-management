class ExperiencesController < ApplicationController
  before_action :correct_user

  def create
    @experience = Experience.new experience_params
    @new_experience = Experience.new profile_id: @profile.id
    if @experience.save
      flash.now[:success] = t ".success"
    else
      flash.now[:error] = t ".error"
    end

    respond_to do |format|
      format.js
    end
  end

  def update; end

  def destroy; end

  private

  def experience_params
    params.require(:experience).permit Experience::EXPERIENCE_PARAMS
  end

  def correct_user
    @profile = Profile.find_by id: params[:experience][:profile_id]
    @user = @profile&.user
    return if current_user && (current_user.eql? @user)

    flash[:error] = t ".error"
    redirect_to root_path
  end
end
