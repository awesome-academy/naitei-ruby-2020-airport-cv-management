RSpec.shared_examples "create example users" do
  before do
    FactoryBot.create(
      :user,
      email: "abcask@ashd.com",
      password: "Test user 1",
      password_confirmation: "Test user 1"
    )
    FactoryBot.create(
      :user,
      email: "abccask@ashd.com",
      password: "Test user 2",
      password_confirmation: "Test user 2"
    )
    FactoryBot.create(
      :user,
      email: "abacask@ashd.com",
      password: "Test user 3",
      password_confirmation: "Test user 3"
    )
  end
end
