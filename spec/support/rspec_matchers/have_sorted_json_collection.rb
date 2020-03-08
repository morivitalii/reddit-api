require "rspec/expectations"

RSpec::Matchers.define :have_sorted_json_collection do |*models|
  match do |response|
    @actual = JSON.parse(response.body).map { |item| item["id"] }
    @expected = models.map(&:id)

    @actual == @expected
  end

  diffable

  failure_message do |_|
    "expected that #{@actual} would be equal to #{@expected}"
  end

  failure_message_when_negated do |_|
    "expected that #{@actual} would not be equal to #{@expected}"
  end
end
