class StaticPagesController < ApplicationController
  def home
    @q = JobPost.ransack params[:q]
    @job_posts = JobPost.home_recent_jobs
    @categories = Category.home_popular_category
  end

  def help; end

  def contact; end

  def about; end
end
