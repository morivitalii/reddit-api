require "rails_helper"

RSpec.describe "User signs in", type: :system do
  context "with form filled by invalid data" do
    it "see errors in form" do
      visit(root_path)
      open_and_submit_sign_in_form_with(nil, nil)

      expect(page).to have_form_errors_on(".new_sign_in_form")
    end
  end

  context "with form filled by valid data" do
    it "successfully signs in" do
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