require "rails_helper"

RSpec.describe "User signs out" do
  it "successfully" do
    user = create(:user)
    sign_in_as(user)

    visit(root_path)
    open_user_menu(user.username)
    click_on(I18n.t("sign_out"))

    within(".first-top-menu") do
      expect(page).to have_content(I18n.t("sign_in"))
    end
  end

  def open_user_menu(username)
    within(".first-top-menu") do
      find("span", text: username).click
    end
  end
end