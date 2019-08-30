require "rails_helper"

RSpec.describe "User signs out" do
  it "signs out user" do
    user = create(:user)
    login_as(user)

    visit(root_path)

    within(".first-top-menu") do
      find("span", text: user.username).click
      click_link(I18n.t("sign_out"))
    end

    expect(page).to_not have_signed_in_user(user)
  end
end