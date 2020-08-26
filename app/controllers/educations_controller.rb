class EducationsController < ApplicationController
  before_action :correct_user

  def create
    @education = Education.new education_params
    @new_education = Education.new profile_id: @profile.id
    if @education.save
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

  def education_params
    params.require(:education).permit Education::EDUCATION_PARAMS
  end

  def correct_user
    @profile = Profile.find_by id: params[:education][:profile_id]
    @user = @profile&.user
    return if current_user && (current_user.eql? @user)

    flash[:error] = t ".error"
    redirect_to root_path
  end
end
