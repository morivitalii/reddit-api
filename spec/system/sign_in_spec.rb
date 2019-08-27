require "rails_helper"

RSpec.describe "Visitor signing in", type: :system do
  context "with wrong credentials" do
    it "and see errors" do
      visit(root_path)
      open_and_submit_sign_in_form_with("wrong@email.com", "wrong_password")

      within(".new_sign_in_form") do
        expect(page).to have_css("span.text-danger")
      end
    end
  end

  context "with right credentials" do
    it "and signs in successfully" do
      user = create(:user)

      visit(root_path)
      open_and_submit_sign_in_form_with(user.username, user.password)

      within(".first-top-menu") do
        expect(page).to have_content(user.username)
      end
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