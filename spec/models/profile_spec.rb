require "rails_helper"

RSpec.describe Profile, type: :model do
  include_examples "create example profiles"
  let!(:user) {FactoryBot.create :user}
  describe "Validations" do
    context "when all required fields given" do
      let!(:profile) {FactoryBot.build :profile, user_id: user.id}
      it "should be true" do
        expect(profile.valid?).to eq true
      end
    end

    context "when missing required fields" do
      let!(:profile_fail) {FactoryBot.build :profile, first_name: nil, last_name: nil}
      it "should be false" do
        expect(profile_fail.valid?).to eq false
      end
    end
  end

  describe "Associations" do
    it "should has many educations" do
      is_expected.to have_many(:educations).dependent(:destroy)
    end

    it "should has many experiences" do
      is_expected.to have_many(:experiences).dependent(:destroy)
    end

    it "should belong to user" do
      is_expected.to belong_to(:user)
    end
  end

  describe "Enums" do
    context "when gender has male, female and X" do
      it "should be true" do
        is_expected.to define_enum_for(:gender).with_values(male: 1, female: 2, third_sex: 3)
      end
    end
  end
end
