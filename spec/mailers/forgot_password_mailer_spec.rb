require "rails_helper"

RSpec.describe ForgotPasswordMailer, type: :mailer do
  it "renders the headers" do
    mail = build_forgot_password_mailer
    expect(mail.subject).to eq(I18n.t("forgot_password_mailer.subject"))
    expect(mail.to).to eq(["email@email.com"])
    expect(mail.from).to eq(["no-reply@readma.ru"])
  end

  it "renders the body" do
    mail = build_forgot_password_mailer
    expected_body = I18n.t("forgot_password_mailer.body_html", url: edit_password_url(token: "token"))

    expect(mail.body.encoded).to match(expected_body)
  end

  def build_forgot_password_mailer
    described_class.with(email: "email@email.com", token: "token").forgot_password
  end
end