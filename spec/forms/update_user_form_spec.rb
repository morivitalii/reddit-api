require "rails_helper"

RSpec.describe UpdateUserForm do
  describe "validations" do
    context "when current password does not match" do
      it "is invalid" do
        form = build_update_user_form
        form.password_current = "wrong_password"

        expect(form).to_not be_valid
      end

      it "has error :invalid on :password_current attribute" do
        form = build_update_user_form
        form.password_current = "wrong_password"

        form.validate

        expect(form).to have_error(:invalid).on(:password_current)
      end
    end

    context "when current password matches" do
      it "is valid" do
        form = build_update_user_form

        expect(form).to be_valid
      end
    end
  end

  describe ".save" do
    it "updates user" do
      form = build_update_user_form

      form.save

      user = form.user
      expect(user.email).to eq(form.email)
      expect(user.password).to eq(form.password)
    end
  end

  def build_update_user_form
    user = create(:user)

    described_class.new(
      user: user,
      email: "email@email.com",
      password: "new_password",
      password_current: user.password
    )
  end
end
