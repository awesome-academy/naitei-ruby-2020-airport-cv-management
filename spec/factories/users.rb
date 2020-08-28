FactoryBot.define do
  factory :user do
    email {Faker::Internet.unique.email}
    password {Settings.validations.user.default_password}
    password_confirmation {Settings.validations.user.default_password}
  end
end
