# frozen_string_literal: true

class ForgotPasswordMailer < ActionMailer::Base
  def forgot_password
    mail(
      to: params[:email],
      subject: t("forgot_password_mailer.subject"),
      body: t("forgot_password_mailer.body_html", url: edit_change_password_url(token: params[:token])),
      content_type: "text/html"
    )
  end
end
