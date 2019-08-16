require "rspec/expectations"

RSpec::Matchers.define :have_error do |value|
  match do |record|
    @actual = record.errors.details[attribute]

    @actual.any? { |error| error.value?(value) }
  end

  chain :on, :attribute
  diffable

  failure_message do |_|
    "expected to have error #{value} on #{attribute} attribute"
  end

  failure_message_when_negated do |_|
    "expected to not have error #{value} on #{attribute} attribute"
  end
end