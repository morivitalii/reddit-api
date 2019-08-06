require "rails_helper"

RSpec.describe SignUpForm do
  subject { described_class }

  describe ".save" do
    context "invalid" do
      before do
        @form = subject.new
      end

      it "adds error on email field if email format is wrong" do
        @form.email = "wrong email format"
        @form.save

        expected_result = { error: :invalid }
        result = @form.errors.details[:email]

        expect(result).to include(expected_result)
      end

      it "adds error on email field if given email is not unique" do
        not_unique_email = create(:user).email

        @form.email = not_unique_email
        @form.save

        expected_result = { error: :email_taken }
        result = @form.errors.details[:email]

        expect(result).to include(expected_result)
      end

      it "adds error on username field if given username format is wrong" do
        @form.username = "wrong username format"
        @form.save

        expected_result = { error: :invalid_username_format }
        result = @form.errors.details[:username]

        expect(result).to include(expected_result)
      end

      it "adds error on username field if given username is not unique" do
        not_unique_username = create(:user).username

        @form.email = not_unique_username
        @form.save

        expected_result = { error: :invalid_username_format }
        result = @form.errors.details[:username]

        expect(result).to include(expected_result)
      end
    end

    context "valid" do
      let(:username) { "username" }
      let(:email) { "email@emal.com" }
      let(:password) { "password" }

      before do
        @form = subject.new(
          username: username,
          email: email,
          password: password
        )
      end

      it "creates user" do
        @form.save

        expected_result = { username: username, email: email, password: password }
        result = @form.user

        expect(result).to have_attributes(expected_result)
      end
    end
  end
end