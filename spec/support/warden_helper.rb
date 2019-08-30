RSpec.configure do |config|
  config.include Warden::Test::Helpers, type: :system

  # Reset warden after each system test
  config.after(:each, type: :system) do
    Warden.test_reset!
  end
end