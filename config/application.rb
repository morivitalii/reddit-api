require_relative "boot"

%w(
  active_record/railtie
  action_controller/railtie
  action_view/railtie
  action_mailer/railtie
  active_job/railtie
  sprockets/railtie
).each do |railtie|
  begin
    require railtie
  rescue LoadError
  end
end

Bundler.require(*Rails.groups)

module App
  class Application < Rails::Application
    config.load_defaults 5.2
    config.action_dispatch.cookies_serializer = :json
    config.active_record.schema_format = :sql
    config.active_job.queue_adapter = :inline
    config.action_mailer.deliver_later_queue_name = "low_priority"
    config.time_zone = "UTC"
    config.active_record.default_timezone = :local
    config.active_record.time_zone_aware_attributes = false
    config.i18n.available_locales = :ru
    config.i18n.default_locale = :ru
    config.filter_parameters += [:username, :email, :password]
    config.action_view.default_form_builder = "FormBuilder"

    ActionView::Base.field_error_proc = Proc.new do |html_tag, _|
      html_tag.html_safe
    end
  end
end
