require "rails_helper"

RSpec.shared_examples "markdownable" do |*attributes|
  attributes.each do |attribute|
    it "defines html method for attribute #{attribute}" do
      expect(described_class.new).to respond_to("#{attribute}_html")
    end
  end
end
