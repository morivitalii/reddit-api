require "rails_helper"

RSpec.describe "User signs up" do
  context "with form filled by invalid data" do
    it "shows errors" do
      visit(root_path)
      open_and_submit_sign_up_form_with(nil, nil, nil)

      expect(page).to have_form_errors_on(".new_sign_up_form")
    end
  end

  context "with form filled by valid data" do
    it "signs up and signs in user" do
      user = instance_double(User, username: "username")

      visit(root_path)
      open_and_submit_sign_up_form_with(user.username, "password", "email@example.com")

      expect(page).to have_signed_in_user(user)
    end
  end

  def open_and_submit_sign_up_form_with(username, password, email)
    click_link(I18n.t("sign_in"))
    click_link(I18n.t("sign_up"))

    within(".new_sign_up_form") do
      fill_in(I18n.t("attributes.username"), with: username)
      fill_in(I18n.t("attributes.password"), with: password)
      fill_in(I18n.t("attributes.email"), with: email)

      click_button(I18n.t("sign_up"))
    end
  end
end