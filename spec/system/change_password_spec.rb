require "rails_helper"

RSpec.describe "User sets new password after restoration procedure", type: :system do
  context "with form filled by invalid data" do
    it "see errors in form" do
      visit(edit_change_password_path(token: "wrong_token"))
      fill_password_form_with("new_password")

      expect(page).to have_errors_on_form(".edit_change_password_form")
    end
  end

  context "with form filled by valid data" do
    it "changes password, signs in and redirects to home page successfully" do
      user = create(:user)

      visit(edit_change_password_path(token: user.forgot_password_token))
      fill_password_form_with("new_password")

      expect(page).to have_current_path(root_path)
      expect(page).to have_signed_in_user(user)
    end
  end

  def fill_password_form_with(password)
    within(".edit_change_password_form") do
      fill_in(I18n.t("attributes.password"), with: password)

      click_on(I18n.t("update"))
    end
  end
end