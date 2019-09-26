require "rails_helper"

RSpec.describe User do
  subject { described_class }

  describe "validations" do
    subject { create(:user) }

    it { is_expected.to have_secure_password }
    it { is_expected.to have_secure_token(:forgot_password_token) }
    it { is_expected.to validate_uniqueness_of(:username).case_insensitive }
    it { is_expected.to allow_value("username").for(:username) }
    it { is_expected.to_not allow_value("incorrect username").for(:username) }
    it { is_expected.to validate_uniqueness_of(:email).case_insensitive }
    it { is_expected.to allow_value("valid@email.com").for(:email) }
    it { is_expected.to_not allow_value("invalid_email.com").for(:email) }
  end

  describe ".to_param" do
    it "returns username" do
      user = build(:user)

      expect(user.to_param).to eq(user.username)
    end
  end
end
