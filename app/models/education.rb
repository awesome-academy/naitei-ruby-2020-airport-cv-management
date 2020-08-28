class Education < ApplicationRecord
  EDUCATION_PARAMS = %i(college major date_from date_to certification additional_information profile_id).freeze
  belongs_to :profile

  delegate :user, to: :profile, prefix: true, allow_nil: true

  validates :college, :major, presence: true,
    length: {minimum: Settings.validations.education.name.minimum,
             maximum: Settings.validations.education.name.maximum}
  validates :date_from, :date_to, presence: true
  validates :certification, :additional_information,
            length: {minimum: Settings.validations.education.text.minimum,
                     maximum: Settings.validations.education.text.maximum}
end
