require "rails_helper"

RSpec.shared_examples_for "strip attributes" do |*attributes, squish: false|
  attributes.each do |attribute|
    describe ".#{attribute}=" do
      it "nullifies #{attribute} value if it is blank" do
        model = subject.new(attribute => "")

        result = model["#{attribute}"]

        expect(result).to be_nil
      end

      it "squishes #{attribute} value if value present and squish option is true", if: squish do
        model = subject.new(attribute => "  value that  must be squished  ")

        expected_result = "value that must be squished"
        result = model["#{attribute}"]

        expect(result).to eq(expected_result)
      end

      it "strips #{attribute} value if value present", unless: squish do
        model = subject.new(attribute => "  value that  must be stripped  ")
        
        expected_result = "value that  must be stripped"
        result = model["#{attribute}"]

        expect(result).to eq(expected_result)
      end
    end
  end
end