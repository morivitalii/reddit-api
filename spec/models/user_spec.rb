require "rails_helper"

RSpec.describe User do
  subject { described_class }

  describe "validations" do
    let(:user) { build(:user) }

    context "invalid" do
      it "if username is not unique" do
        other_user = create(:user)
        user.username = other_user.username
        user.validate

        expected_result = { error: :taken }
        result = user.errors.details[:username]

        expect(result).to include(hash_including(expected_result))
      end

      it "if email not unique" do
        other_user = create(:user)
        user.email = other_user.email
        user.validate

        expected_result = { error: :taken }
        result = user.errors.details[:email]

        expect(result).to include(hash_including(expected_result))
      end

      it "if email format invalid"do
        user.email = "invalid email"
        user.validate

        expected_result = { error: :invalid }
        result = user.errors.details[:email]

        expect(result).to include(hash_including(expected_result))
      end
    end

    context "valid" do
      it { expect(user).to be_valid }
    end
  end

  describe ".to_param" do
    it "returns user username" do
      user = build(:user)

      expected_result = user.username
      result = user.to_param

      expect(result).to eq(expected_result)
    end
  end
end