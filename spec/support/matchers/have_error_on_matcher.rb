require "rspec/expectations"

RSpec::Matchers.define :have_error do |expected|
  match do |actual|
    @actual = actual.errors.details[attribute]

    @actual.any? { |error| error.value?(expected) }
  end

  chain :on, :attribute
  diffable

  failure_message do |_|
    "expected to have error #{expected} on #{attribute} attribute"
  end

  failure_message_when_negated do |_|
    "expected to not have error #{expected} on #{attribute} attribute"
  end
end