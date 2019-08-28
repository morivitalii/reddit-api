require "rspec/expectations"

RSpec::Matchers.define :have_error do |error|
  match do |model|
    @actual = model.errors.details[attribute]

    @actual.any? { |actual_error| actual_error.value?(error) }
  end

  chain :on, :attribute
  diffable

  failure_message do |_|
    "error to have error #{error} on #{attribute} attribute"
  end

  failure_message_when_negated do |_|
    "error to not have error #{error} on #{attribute} attribute"
  end
end