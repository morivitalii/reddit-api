require "rails_helper"

RSpec.shared_examples_for "markdownable" do |*attributes|
  attributes.each do |attribute|
    it "defines html method for attribute #{attribute}" do
      expect(subject.new).to respond_to("#{attribute}_html")
    end
  end
end