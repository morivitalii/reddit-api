require "rails_helper"

RSpec.describe "User restore forgotten password" do
  it "see notification with success text" do
    visit(root_path)
    open_and_submit_forgot_password_form_with("email@example.com")

    expect(page).to have_content("Письмо с ссылкой на изменение пароля отправлено на указанный email")
  end

  def open_and_submit_forgot_password_form_with(email)
    click_on(I18n.t("sign_in"))
    click_on(I18n.t("forgot_password"))

    within(".new_forgot_password_form") do
      fill_in(I18n.t("attributes.email"), with: email)
      click_on(I18n.t("forgot_password"))
    end
  end
end