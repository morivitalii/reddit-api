require "rails_helper"

RSpec.describe CreatePageForm do
  subject { described_class.new(title: title, text: text) }

  let(:title) { "Title" }
  let(:text) { "Text" }

  describe ".save" do
    it "creates page" do
      subject.save
      result = subject.page

      expect(result).to have_attributes(title: title, text: text)
    end
  end
end