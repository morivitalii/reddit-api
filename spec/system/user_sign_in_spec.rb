require "rails_helper"

RSpec.describe "User signs in", type: :system do
  context "with wrong credentials" do
    it "and see errors" do
      visit(root_path)
      open_and_submit_sign_in_form_with("wrong@email.com", "wrong_password")

      expect(page).to have_errors_on_form(".new_sign_in_form")
    end
  end

  context "with right credentials" do
    it "successfully" do
      user = create(:user)

      visit(root_path)
      open_and_submit_sign_in_form_with(user.username, user.password)

      expect(page).to have_signed_in_user(user)
    end
  end

  def open_and_submit_sign_in_form_with(username, password)
    click_on(I18n.t("sign_in"))

    within(".new_sign_in_form") do
      fill_in(I18n.t("attributes.username"), with: username)
      fill_in(I18n.t("attributes.password"), with: password)

      click_on(I18n.t("sign_in"))
    end
  end
end