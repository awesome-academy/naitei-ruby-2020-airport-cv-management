class User < ApplicationRecord
  VALID_EMAIL_REGEX = Settings.validations.user.email_regex
  USER_PARAMS = %i(email password password_confirmation).freeze

  attr_accessor :remember_token, :activation_token, :reset_token

  belongs_to :role
  belongs_to :unit, optional: true
  has_many :job_applications, dependent: :destroy, foreign_key: "candidate_id",
           class_name: JobApplication.name
  has_one :profile, dependent: :destroy
  has_many :job_posts, dependent: :destroy

  accepts_nested_attributes_for :profile

  delegate :full_name, :introduction, :phone_number, to: :profile, allow_nil: true
  delegate :id, to: :role, prefix: true, allow_nil: true
  delegate :id, to: :unit, prefix: true, allow_nil: true

  validates :email, presence: true,
    length: {minimum: Settings.validations.user.email_minlength,
             maximum: Settings.validations.user.email_maxlength},
    format: {with: VALID_EMAIL_REGEX},
    uniqueness: true

  validates :password, presence: true,
    length: {minimum: Settings.validations.user.password_minlength,
             maximum: Settings.validations.user.password_maxlength},
    allow_nil: true

  before_save :downcase_email
  before_create :create_activation_digest

  has_secure_password

  class << self
    def digest string
      cost = if ActiveModel::SecurePassword.min_cost
               BCrypt::Engine::MIN_COST
             else
               BCrypt::Engine.cost
             end
      BCrypt::Password.create string, cost: cost
    end

    def new_token
      SecureRandom.urlsafe_base64
    end
  end

  def remember
    self.remember_token = User.new_token
    update :remember_digest, User.digest(remember_token)
  end

  def authenticated? attribute, token
    digest = send "#{attribute}_digest"
    return false unless digest

    BCrypt::Password.new(digest).is_password? token
  end

  def forget
    update remember_digest: nil
  end

  def activate
    update activated: true, activated_at: Time.zone.now
  end

  def send_activation_email
    UserMailer.account_activation(self).deliver_now
  end

  def create_reset_digest
    self.reset_token = User.new_token
    update reset_digest: User.digest(reset_token), reset_sent_at: Time.zone.now
  end

  def send_password_reset_email
    UserMailer.password_reset(self).deliver_now
  end

  def password_reset_expired?
    reset_sent_at < Settings.validations.user.password_reset_expired.hours.ago
  end

  def is_candidate?
    return true if role_id.eql? Settings.role.candidate

    false
  end

  def is_recruiter?
    role_id.eql?(Settings.role.recruiter) && unit_id.eql?(Settings.unit.hr)
  end

  def is_not_hr?
    role_id.eql?(Settings.role.recruiter) && !unit_id.eql?(Settings.unit.hr)
  end

  private

  def downcase_email
    email.downcase!
  end

  def create_activation_digest
    self.activation_token = User.new_token
    self.activation_digest = User.digest activation_token
  end
end
