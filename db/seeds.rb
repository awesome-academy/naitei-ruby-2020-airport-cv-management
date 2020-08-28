Role.create! id: 1, name: "candidate"
Role.create! id: 2, name: "recruiter"
Role.create! id: 3, name: "admin"

Gender.create! id: 1, name: "M"
Gender.create! id: 2, name: "F"
Gender.create! id: 3, name: "X"

JobApplicationStatus.create! id: 1, title: "reviewing"
JobApplicationStatus.create! id: 2, title: "denied"
JobApplicationStatus.create! id: 3, title: "interviewing"
JobApplicationStatus.create! id: 4, title: "accepted"
JobApplicationStatus.create! id: 5, title: "cancelled"

Unit.create! id: 1,
             name: "HR",
             address: Faker::Address.full_address,
             email: Faker::Internet.email,
             phone_number: Faker::PhoneNumber.cell_phone_in_e164,
             overview: Faker::Lorem.paragraph

10.times do |n|
  Unit.create! name: Faker::Company.name,
               address: Faker::Address.full_address,
               email: Faker::Internet.email,
               phone_number: Faker::PhoneNumber.cell_phone_in_e164,
               overview: Faker::Lorem.paragraph
end

10.times do |n|
  password = "password"
  User.create! email: "recruiter-#{n+1}@airport.org",
               password: password,
               password_confirmation: password,
               unit_id: 1,
               role_id: 2,
               activated: true,
               activated_at: Time.zone.now
end

99.times do |n|
  password = "password"
  User.create! email: "example-#{n+1}@airport.org",
               password: password,
               password_confirmation: password,
               activated: true,
               activated_at: Time.zone.now
end

15.times do |n|
  Category.create! title: Faker::Job.field
end

20.times do |n|
  JobPost.create! title: Faker::Job.title,
                  location: Faker::Address.full_address,
                  salary_from: rand(100..200),
                  salary_to: rand(200..500),
                  note: Faker::Lorem.paragraph,
                  category_id: rand(1..15),
                  user_id: rand(1..10),
                  unit_id: rand(1..10),
                  description: Faker::Lorem.paragraph,
                  requirement: Faker::Lorem.paragraph
end

100.times do |n|
  JobApplication.create! candidate_id: rand(11..21),
                         recruiter_id: rand(1..10),
                         job_application_status_id: 1,
                         job_post_id: rand(1..20)
end

users = User.all
users.each do |user|
  profile = user.build_profile first_name: Faker::Name.first_name,
                               last_name: Faker::Name.last_name,
                               introduction: Faker::Lorem.paragraph_by_chars(number: 256, supplemental: false),
                               date_of_birth: Faker::Date.between(from: '1989-09-23', to: '2002-09-25'),
                               gender_id: Faker::Number.between(from: 1, to: 3),
                               address: Faker::Address.full_address,
                               phone_number: "0987654321"
  profile.save
end

10.times do |n|
  Education.create college: Faker::University.name,
                   major: Faker::Job.title,
                   date_from: Faker::Date.between(from: '2014-09-23', to: '2016-09-25'),
                   date_to: Faker::Date.between(from: '2019-09-23', to: '2022-09-25'),
                   certification: Faker::Games::LeagueOfLegends.rank,
                   additional_information: Faker::Games::LeagueOfLegends.quote,
                   profile_id: rand(1..6)
end

10.times do |n|
  Experience.create company_name: Faker::University.name,
                    job_position: Faker::Job.position,
                    date_from: Faker::Date.between(from: '2014-09-23', to: '2016-09-25'),
                    date_to: Faker::Date.between(from: '2016-09-25', to: '2019-09-25'),
                    additional_information: Faker::Games::LeagueOfLegends.quote,
                    profile_id: rand(1..6)
end
