Rails.application.configure do
  config.cache_classes = true
  config.eager_load = true
  config.consider_all_requests_local = false
  config.action_controller.perform_caching = true
  config.require_master_key = true
  config.public_file_server.enabled = ENV["RAILS_SERVE_STATIC_FILES"].present?
  config.assets.js_compressor = :uglifier
  config.assets.css_compressor = :sass
  config.assets.compile = false
  config.force_ssl = true
  config.log_level = :error
  config.log_tags = [:request_id]
  config.cache_store = :memory_store
  config.active_job.queue_adapter = :inline
  config.active_job.queue_name_prefix = Rails.env
  config.action_mailer.perform_caching = false
  config.i18n.fallbacks = true
  config.active_support.deprecation = :notify
  config.log_formatter = ::Logger::Formatter.new
  config.active_record.dump_schema_after_migration = false
  config.session_store :cookie_store, expire_after: 1.month, secure: true
  config.action_mailer.default_url_options = { host: "readma.ru" }
  config.action_mailer.default_options = { from: "no-reply@readma.ru" }
  config.action_mailer.delivery_method = :smtp
  config.action_mailer.smtp_settings = {
    user_name: ENV.fetch("SMTP_USER_NAME"),
    password: ENV.fetch("SMTP_PASSWORD"),
    address: ENV.fetch("SMTP_ADDRESS"),
    domain: ENV.fetch("SMTP_DOMAIN"),
    port: ENV.fetch("SMTP_PORT"),
    authentication: "login",
    enable_starttls_auto: true
  }

  if ENV["RAILS_LOG_TO_STDOUT"].present?
    logger = ActiveSupport::Logger.new(STDOUT)
    logger.formatter = config.log_formatter
    config.logger = ActiveSupport::TaggedLogging.new(logger)
  end
end
