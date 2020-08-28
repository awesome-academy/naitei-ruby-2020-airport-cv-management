class JobApplication < ApplicationRecord
  belongs_to :job_post
  belongs_to :candidate, class_name: User.name
  belongs_to :recruiter, class_name: User.name, optional: true

  delegate :title, to: :job_post, prefix: true, allow_nil: true
  delegate :category_title, to: :job_post, prefix: true, allow_nil: true
  delegate :location, to: :job_post, prefix: true, allow_nil: true
  delegate :phone_number, to: :candidate, prefix: true, allow_nil: true

  enum status: {reviewing: "reviewing",
                interviewing: "interviewing",
                accepted: "accepted",
                denied: "denied",
                cancelled: "cancelled"}

  scope :desc_order, ->{order created_at: :desc}
end
