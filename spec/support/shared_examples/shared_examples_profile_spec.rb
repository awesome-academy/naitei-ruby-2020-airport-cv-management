RSpec.shared_examples "create example profiles" do
  before do
    FactoryBot.create(
      :profile,
      first_name: "Test Profile 0",
      last_name: "Test Profile 0",
      phone_number: "0985656156",
      date_of_birth: "1989-09-23",
      address: "Test Address 1",
      introduction: "Test Description 1",
      gender: 1,
      user_id: user.id
    )
    FactoryBot.create(
      :profile,
      first_name: "Test Profile 1",
      last_name: "Test Profile 1",
      phone_number: "0985656256",
      date_of_birth: "1989-09-23",
      address: "Test Address 1,2",
      introduction: "Test Description 1",
      gender: 1,
      user_id: user.id
    )
    FactoryBot.create(
      :profile,
      first_name: "Test Profile 2",
      last_name: "Test Profile 2",
      phone_number: "0985656356",
      date_of_birth: "1989-09-23",
      address: "Test Address 3",
      introduction: "Test Description 3",
      gender: 2,
      user_id: user.id
    )
  end
end
