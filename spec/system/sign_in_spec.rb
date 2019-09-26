require "rails_helper"

RSpec.describe "Sign in" do
  context "with form filled by invalid data" do
    it "shows errors" do
      visit(root_path)
      open_and_submit_sign_in_form_with(nil, nil)

      expect(page).to have_form_errors_on(".new_sign_in_form")
    end
  end

  context "with form filled by valid data" do
    it "signs in user" do
      user = create(:user)

      visit(root_path)
      open_and_submit_sign_in_form_with(user.username, user.password)

      expect(page).to have_signed_in_user(user)
    end
  end

  def open_and_submit_sign_in_form_with(username, password)
    click_link(I18n.t("layouts.application.sign_in"))

    within(".new_sign_in_form") do
      fill_in(I18n.t("activemodel.attributes.sign_in_form.username"), with: username)
      fill_in(I18n.t("activemodel.attributes.sign_in_form.password"), with: password)

      click_button(I18n.t("sign_in.new.submit"))
    end
  end
end
