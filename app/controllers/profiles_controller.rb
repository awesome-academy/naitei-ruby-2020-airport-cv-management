class ProfilesController < ApplicationController
  before_action :must_logged_in
  before_action :load_profile, only: %i(show edit update)
  before_action :correct_user_or_recruiter

  def show; end

  def edit
    @new_education = Education.new profile_id: @profile.id
    @new_experience = Experience.new profile_id: @profile.id
  end

  def update
    if @profile.update profile_params
      flash[:success] = t ".profile_updated"
    else
      flash[:error] = t ".profile_update_failed"
    end

    respond_to do |format|
      format.html{render :edit}
      format.js
    end
  end

  private

  def load_profile
    @profile = Profile.find_by id: params[:id]
    return if @profile

    flash[:warning] = t ".profile_not_found"
    redirect_to root_path
  end

  def correct_user_or_recruiter
    redirect_to root_url unless (@profile&.user == current_user) || current_user&.is_recruiter?
  end

  def must_logged_in
    redirect_to root_url unless logged_in?
  end

  def profile_params
    params.require(:profile).permit Profile::PROFILE_PARAMS
  end
end
