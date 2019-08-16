require "rails_helper"

RSpec.describe UsersQuery do
  subject { described_class }

  describe ".with_forgot_password_token" do
    it "returns user with given forgot_password_token" do
      user = create(:user)
      create_pair(:user)

      result = subject.new.with_forgot_password_token(user.forgot_password_token).take

      expect(result).to eq(user)
    end
  end

  describe ".with_username" do
    it "returns user with given username" do
      user = create(:user)
      create_pair(:user)

      result = subject.new.with_username(user.username).take

      expect(result).to eq(user)
    end
  end

  describe ".with_email" do
    it "returns user with given username" do
      user = create(:user)
      create_pair(:user)

      result = subject.new.with_email(user.email).take

      expect(result).to eq(user)
    end
  end
end