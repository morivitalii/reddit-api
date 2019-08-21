Recaptcha.configure do |config|
  if Rails.env.production?
    config.site_key = ENV.fetch("RECAPTCHA_SITE_KEY")
    config.secret_key = ENV.fetch("RECAPTCHA_SECRET_KEY")
  elsif Rails.env.development?
    config.site_key = "6LfSh4oUAAAAAGWI8uuBh4ndFuYUKETljRjCMOx6"
    config.secret_key = "6LfSh4oUAAAAAMLUb6MBWRyh2J9ZwgGg_xmrz9FI"
  end
end
