class ExperiencesController < ApplicationController
  before_action :correct_user, only: :create
  before_action :load_experience, only: %i(destroy update)

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

  def destroy
    if @experience.destroy
      flash.now[:success] = t ".success"
    else
      flash.now[:error] = t ".error"
    end
    respond_to do |format|
      format.js
    end
  end

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

  def load_experience
    @experience = Experience.find_by id: params[:id]
    return if @experience && current_user && current_user.eql?(@experience.profile_user)

    flash.now[:error] = t ".not_found"
    respond_to do |format|
      format.js
    end
  end
end
