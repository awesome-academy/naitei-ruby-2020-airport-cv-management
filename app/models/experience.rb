class Experience < ApplicationRecord
  EXPERIENCE_PARAMS = %i(company_name job_position date_from date_to additional_information profile_id).freeze
  belongs_to :profile

  validates :company_name, presence: true,
    length: {minimum: Settings.validations.experience.company_name.minimum,
             maximum: Settings.validations.experience.company_name.maximum}
  validates :date_from, :date_to, presence: true
  validates :job_position, presence: true,
    length: {minimum: Settings.validations.experience.job_position.minimum,
             maximum: Settings.validations.experience.job_position.maximum}
  validates :additional_information, allow_nil: true,
    length: {maximum: Settings.validations.experience.additional_information.maximum}
end
