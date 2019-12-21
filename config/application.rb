require_relative "boot"

require "rails"
# Pick the frameworks you want:
require "active_model/railtie"
require "active_job/railtie"
require "active_record/railtie"
require "action_controller/railtie"
require "action_mailer/railtie"
# require "active_storage/engine"
# require "action_mailbox/engine"
# require "action_text/engine"
# require "action_cable/engine"
# require "action_view/railtie"

Bundler.require(*Rails.groups)

module App
  class Application < Rails::Application
    config.load_defaults 6.0
    config.active_record.schema_format = :sql
    # Fuck those useless queries. Database will throw error if shit happens. That's fine
    config.active_record.belongs_to_required_by_default = false
    config.active_job.queue_adapter = :inline
    config.action_mailer.deliver_later_queue_name = "low_priority"
    config.i18n.available_locales = :ru
    config.i18n.default_locale = :ru
    config.filter_parameters += [:username, :email, :password]
  end
end
