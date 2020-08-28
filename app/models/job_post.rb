class JobPost < ApplicationRecord
  JOBPOST_PARAMS = %i(title location salary_from salary_to note description requirement category_id unit_id).freeze

  belongs_to :category
  belongs_to :user
  belongs_to :unit

  delegate :title, to: :category, prefix: true, allow_nil: true
  delegate :name, to: :unit, prefix: true, allow_nil: true
  delegate :title, :id, to: :job_application_status, prefix: true, allow_nil: true
  delegate :id, to: :job_post, prefix: true, allow_nil: true

  validates :user_id, presence: true
  validates :title, presence: true,
    length: {minimum: Settings.validations.job_post.title_min,
             maximum: Settings.validations.job_post.title_max}
  validates :location, presence: true,
    length: {minimum: Settings.validations.job_post.content_min,
             maximum: Settings.validations.job_post.content_max}
  validates :salary_from, :salary_to, presence: true,
    numericality: {greater_than: Settings.validations.job_post.min,
                   less_than: Settings.validations.job_post.max}
  validates :description, presence: true,
    length: {minimum: Settings.validations.job_post.content_min,
             maximum: Settings.validations.job_post.content_max}
  validates :requirement, presence: true,
    length: {minimum: Settings.validations.job_post.content_min,
             maximum: Settings.validations.job_post.content_max}
  validates :note, allow_nil: true,
    length: {minimum: Settings.validations.job_post.content_min,
             maximum: Settings.validations.job_post.content_max}

  scope :home_recent_jobs, ->{order(created_at: :desc).limit Settings.job}

  def applied_by user
    job_application = user.job_applications.find_by(job_post_id: id)
    job_application.present? && job_application.cancelled?
  end
end
