# Run server in silent mode to prevent breaking tests output with puma start message
Capybara.server = :puma, {Silent: true}

RSpec.configure do |config|
  # Change default capybara driver for system specs
  config.before(:each, type: :system) do
    driven_by :selenium, using: :headless_chrome
  end

  # Seed database with necessary data before each system test
  config.before(:example, type: :system) do
    Rails.application.load_seed
  end
end
