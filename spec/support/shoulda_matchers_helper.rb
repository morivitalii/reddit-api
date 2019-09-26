Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    with.test_framework :rspec
    with.library :rails
  end
end

RSpec.configure do |config|
  # Shoulda-matchers helper methods for form specs
  config.include Shoulda::Matchers::ActiveModel, type: :form
end
