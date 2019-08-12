require "rails_helper"

RSpec.describe UpdateUserForm do
  subject { described_class }

  describe ".save" do
    context "invalid" do
      before do
        @form = subject.new
      end

      it "if current_password does not match user password" do
        allow(@form).to receive(:current_password_match?).and_return(false)

        @form.validate

        expected_result = { error: :invalid_current_password }
        result = @form.errors.details[:password_current]

        expect(result).to include(expected_result)
      end
    end

    context "valid" do
      before do
        @user = instance_double(User)
        @form = subject.new(user: @user, email: double, password: double, password_current: double)

        allow(@form).to receive(:current_password_match?).and_return(true)
      end

      it { expect(@form).to be_valid }

      it "updates user" do
        expect(@user).to receive(:update!).with(email: anything, password: anything)

        @form.save
      end
    end
  end
end