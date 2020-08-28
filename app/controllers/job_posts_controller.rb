class JobPostsController < ApplicationController
  before_action :recruiter_user, except: %i(show index)
  before_action :load_job_posts, only: :show

  def index
    @q = JobPost.ransack params[:q]
    @job_posts = @q.result(distinct: true).page(params[:page]).per Settings.job_posts.per_page
  end

  def new
    @job_post = JobPost.new
  end

  def show; end

  def create
    @job_post = current_user.job_posts.build job_post_params
    if @job_post.save
      flash[:success] = t ".success"
      redirect_to root_path
    else
      flash[:error] = t ".error"
      render :new
    end
  end

  private

  def job_post_params
    params.require(:job_post).permit JobPost::JOBPOST_PARAMS
  end

  def recruiter_user
    redirect_to root_url unless current_user.is_recruiter?
  end

  def load_job_posts
    @job_post = JobPost.find_by id: params[:id]
    return if @job_post

    flash[:warning] = t ".job_post_not_found"
    redirect_to root_path
  end
end
