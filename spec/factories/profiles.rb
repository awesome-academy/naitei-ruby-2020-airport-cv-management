FactoryBot.define do
  factory :profile do
    first_name {Faker::Name.first_name}
    last_name {Faker::Name.last_name}
    introduction {Faker::Lorem.paragraph_by_chars(number: 256, supplemental: false)}
    date_of_birth {Faker::Date.between(from: '1989-09-23', to: '2002-09-25')}
    gender {Faker::Number.between(from: 1, to: 3)}
    address {Faker::Address.full_address}
    phone_number {"09#{Faker::Number.unique.number(digits: 8)}"}
  end
end
