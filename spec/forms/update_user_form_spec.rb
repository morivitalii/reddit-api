require "rails_helper"

RSpec.describe UpdateUserForm do
  subject { described_class }

  let(:user) { double(:user, id: "", authenticate: "", update!: "") }

  describe ".save" do
    context "invalid" do
      before do
        @form = subject.new(user: user, email: "")
      end

      it "adds error on email field if email format is wrong" do
        @form.email = "wrong email format"
        @form.save

        expected_result = { error: :invalid }
        result = @form.errors.details[:email]

        expect(result).to include(expected_result)
      end

      it "adds error on email field if given email is not unique" do
        allow(@form).to receive(:email_unique?).and_return(false)
        @form.save

        expected_result = { error: :email_taken }
        result = @form.errors.details[:email]

        expect(result).to include(expected_result)
      end

      it "adds error on current_password field if given password does not match user password" do
        allow(@form).to receive(:current_password_match?).and_return(false)
        @form.save

        expected_result = { error: :invalid_current_password }
        result = @form.errors.details[:password_current]

        expect(result).to include(expected_result)
      end
    end

    context "valid" do
      before do
        @form = subject.new(
          user: user,
          email: email,
          password_current: "password"
        )

        allow(@form).to receive(:current_password_match?).and_return(true)
        allow(@form).to receive(:email_unique?).and_return(true)
      end

      let(:email) { "email@email.com" }

      it "update user email" do
        @form.save

        expect(user).to have_received(:update!).with(email: email).once
      end

      let(:password) { "password" }

      it "update user password only if new password is given" do
        @form.password = password
        @form.save

        expect(user).to have_received(:update!).with(hash_including(password: password)).once
      end
    end
  end
end