require "rails_helper"

RSpec.describe CreateTagForm do
  subject { described_class.new(title: title) }

  let(:title) { "Title" }

  describe ".save" do
    it "creates tag" do
      subject.save
      result = subject.tag

      expect(result).to have_attributes(title: title)
    end
  end
end