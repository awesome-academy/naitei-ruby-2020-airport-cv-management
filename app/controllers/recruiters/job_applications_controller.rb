class Recruiters::JobApplicationsController < ApplicationController
  layout "recruiters_application"
  before_action :authenticate_user!
  STATUS_PARAMS = %i(status).freeze

  def index
    if current_user.has_role? :recruiter
      @q = JobApplication.ransack params[:q]
      @job_applications = @q.result(distinct: true).page(params[:page]).per Settings.job_application
    else

      candidate_index
    end
    respond_to do |format|
      format.html{render :index}
      format.js
    end
  end

  def show; end

  def create
    @job_application = JobApplication.new candidate_id: current_user&.id,
                                          job_post_id: params[:id]
    if @job_application.save
      flash[:success] = t "send.ok"
      redirect_to job_applications_path
    else
      flash[:error] = t "send.error"
      redirect_to root_url
    end
  end

  def update
    @job_application = JobApplication.find_by id: params[:id]
    update_status if current_user.has_role?(:recruiter) || current_user.eql?(@job_application&.candidate)
  end

  private

  def status_params
    params.require(:job_application).permit STATUS_PARAMS
  end

  def candidate_index
    return unless current_user.has_role? :candidate

    @job_applications = current_user.job_applications
                                    .desc_order
                                    .page(params[:page])
                                    .per(Settings.job_applications.per_page)
  end

  def update_status
    if @job_application.update status_params
      flash.now[:success] = t ".success"
    else
      flash.now[:error] = t ".error"
    end
    respond_to do |format|
      format.js
    end
  end
end
