require "rails_helper"

RSpec.shared_examples_for "squished attribute" do |attribute|
  describe ".#{attribute}=" do
    it "squish value" do
      subject.send("#{attribute}=", "  value that  must be squished  ")

      expected_result = "value that must be squished"
      result = subject["#{attribute}"]

      expect(result).to eq(expected_result)
    end
  end
end