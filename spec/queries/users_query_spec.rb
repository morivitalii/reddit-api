require "rails_helper"

RSpec.describe UsersQuery do
  subject { described_class.new }

  describe ".where_forgot_password_token" do
    let!(:users) { create_pair(:user) }

    it "returns user with given forgot_password_token" do
      expected_result = [users.first]
      token = expected_result.first.forgot_password_token
      result = subject.where_forgot_password_token(token)

      expect(result).to eq(expected_result)
    end
  end

  describe ".where_username" do
    let!(:users) { create_pair(:user) }

    it "returns user with given username" do
      expected_result = [users.first]
      username = expected_result.first.username
      result = subject.where_username(username)

      expect(result).to eq(expected_result)
    end
  end

  describe ".where_email" do
    let!(:users) { create_pair(:user) }

    it "returns user with given email" do
      expected_result = [users.first]
      email = expected_result.first.email
      result = subject.where_email(email)

      expect(result).to eq(expected_result)
    end
  end

  describe ".auto_moderator" do
    let!(:auto_moderator) { create(:user, username: "AutoModerator") }
    let!(:users) { [create(:user)] }

    it "returns user with AutoModerator username" do
      expected_result = [auto_moderator]
      result = subject.auto_moderator.all

      expect(result).to eq(expected_result)
    end
  end
end