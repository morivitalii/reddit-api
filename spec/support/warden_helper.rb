RSpec.configure do |config|
  config.include Warden::Test::Helpers, type: :request

  # Reset warden after each system test
  config.after(:each, type: :request) do
    Warden.test_reset!
  end
end
