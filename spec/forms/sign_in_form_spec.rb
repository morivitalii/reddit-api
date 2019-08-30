require "rails_helper"

RSpec.describe SignInForm do
  it { expect(described_class.new).to_not be_persisted }

  context "when user with given username does not exist" do
    it "is invalid" do
      form = build_sign_in_form
      form.username = "wrong_username"

      expect(form).to_not be_valid
    end

    it "has error :invalid_credentials on username attribute" do
      form = build_sign_in_form
      form.password = "wrong_password"

      form.validate

      expect(form).to have_error(:invalid_credentials).on(:username)
    end
  end

  context "when user with given username exists" do
    context "and password does not match" do
      it "is invalid" do
        form = build_sign_in_form
        form.password = "wrong_password"

        expect(form).to_not be_valid
      end

      it "has error :invalid_credentials on username attribute" do
        form = build_sign_in_form
        form.password = "wrong_password"

        form.validate

        expect(form).to have_error(:invalid_credentials).on(:username)
      end
    end

    context "and credentials match" do
      it "is valid" do
        form = build_sign_in_form

        expect(form).to be_valid
      end
    end
  end

  def build_sign_in_form
    user = create(:user)

    described_class.new(
      username: user.username,
      password: user.password
    )
  end
end