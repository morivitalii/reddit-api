require "rails_helper"

RSpec.describe "Forgot password" do
  it "shows notification with success text" do
    visit(root_path)
    open_and_submit_forgot_password_form_with("email@example.com")

    expect(page).to have_success_notification
  end

  def open_and_submit_forgot_password_form_with(email)
    click_link(I18n.t("layouts.application.sign_in"))
    click_link(I18n.t("sign_in.new.forgot_password"))

    within(".new_forgot_password_form") do
      fill_in(I18n.t("activemodel.attributes.forgot_password_form.email"), with: email)

      click_button(I18n.t("forgot_password.new.submit"))
    end
  end

  def have_success_notification
    have_content("Письмо с ссылкой на изменение пароля отправлено на указанный email")
  end
end