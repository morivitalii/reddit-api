require "rails_helper"

RSpec.describe UsersQuery do
  subject { described_class }

  describe ".with_forgot_password_token" do
    let!(:expected) { create(:user) }
    let!(:others) { create_pair(:user) }

    it "returns result filtered by forgot_password_token" do
      result = subject.new.with_forgot_password_token(expected.forgot_password_token).take

      expect(result).to eq(expected)
    end
  end

  describe ".with_username" do
    let!(:expected) { create(:user) }
    let!(:others) { create_pair(:user) }

    it "returns result filtered by username" do
      result = subject.new.with_username(expected.username).take

      expect(result).to eq(expected)
    end
  end

  describe ".with_email" do
    let!(:expected) { create(:user) }
    let!(:others) { create_pair(:user) }

    it "returns result filtered by email" do
      result = subject.new.with_email(expected.email).take

      expect(result).to eq(expected)
    end
  end

  describe ".auto_moderator" do
    it "calls .with_username with 'AutoModerator'" do
      query = subject.new

      expect(query).to receive(:with_username).with("AutoModerator")

      query.auto_moderator
    end
  end
end