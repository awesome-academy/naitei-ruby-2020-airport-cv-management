class JobApplication < ApplicationRecord
  belongs_to :job_post

  belongs_to :candidate, class_name: User.name
  belongs_to :recruiter, class_name: User.name
end
