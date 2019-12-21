Rails.application.configure do
  config.cache_classes = false
  config.eager_load = false
  config.consider_all_requests_local = true
  config.cache_store = :null_store
  config.active_job.queue_adapter = :test
  config.action_controller.perform_caching = false
  config.action_dispatch.show_exceptions = false
  config.action_controller.allow_forgery_protection = false
  config.action_mailer.perform_caching = false
  config.action_mailer.default_options = {from: "no-reply@readma.ru"}
  config.action_mailer.delivery_method = :test
  config.active_support.deprecation = :stderr
  config.action_mailer.default_url_options = {host: "localhost", port: 3000}
  config.public_file_server.enabled = true
  config.public_file_server.headers = {"Cache-Control" => "public, max-age=#{1.hour.to_i}"}
  config.i18n.fallbacks = true
end
