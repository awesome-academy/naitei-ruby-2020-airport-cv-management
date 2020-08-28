class JobApplication < ApplicationRecord
  belongs_to :job_post
  belongs_to :job_application_status
  belongs_to :candidate, class_name: User.name
  belongs_to :recruiter, class_name: User.name, optional: true

  delegate :title, to: :job_post, prefix: true, allow_nil: true
  delegate :category_title, to: :job_post, prefix: true, allow_nil: true
  delegate :location, to: :job_post, prefix: true, allow_nil: true
  delegate :title, :id, to: :job_application_status, prefix: true, allow_nil: true
  delegate :phone_number, to: :candidate, prefix: true, allow_nil: true

  scope :desc_order, ->{order created_at: :desc}
end
