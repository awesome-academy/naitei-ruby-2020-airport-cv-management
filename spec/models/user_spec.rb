require "rails_helper"

RSpec.describe User, :type => :model do
  include_examples "create example users"
  let(:user) {FactoryBot.create :user}
  let!(:user_fail) {FactoryBot.build :user, email: nil}

  describe "Validations" do
    context "when all required fields given" do
      it "should be true" do
        expect(user.valid?).to eq true
      end
    end

    context "when missing required fields" do
      it "should be false" do
        expect(user_fail.valid?).to eq false
      end
    end
  end

  describe "Enums" do
    context "when roles have candidate, recruiter, admin" do
      it "should be true" do
        is_expected.to define_enum_for(:roles).with_values(candidate: 1, recruiter: 2, admin: 3)
      end
    end
  end

  describe "Associations" do
    it "should has many job applications" do
      is_expected.to have_many(:job_applications).dependent(:destroy)
    end

    it "should has many job posts" do
      is_expected.to have_many(:job_posts).dependent(:destroy)
    end

    it "should has one profiles" do
      is_expected.to have_one(:profile).dependent(:destroy)
    end
  end

  describe ".new_token" do
    it "new token should be successfully generated" do
      expect(User.new_token.size > 0).to eq(true)
    end
  end
end
