require "rails_helper"

RSpec.describe "user create text post", type: :system do
  it "sees new text post page" do
    visit("/404")
    expect(page.body).to match("Войти")
  end

  it "clicks on sign un button and see form appeared" do
    user = create(:user)

    visit(root_path)

    click_link("Войти")

    within ".signInForm" do
      fill_in("username", with: user.username)
      fill_in("password", with: user.password)
      click_button
    end

    expect(page).to have_content(user.username)
  end
end