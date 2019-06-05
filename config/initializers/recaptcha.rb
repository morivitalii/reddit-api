Recaptcha.configure do |config|
  if Rails.env.production?
    config.site_key = Rails.application.credentials.recaptcha_site_key
    config.secret_key = Rails.application.credentials.recaptcha_secret_key
  else
    config.site_key = "6LfSh4oUAAAAAGWI8uuBh4ndFuYUKETljRjCMOx6"
    config.secret_key = "6LfSh4oUAAAAAMLUb6MBWRyh2J9ZwgGg_xmrz9FI"
  end
end
