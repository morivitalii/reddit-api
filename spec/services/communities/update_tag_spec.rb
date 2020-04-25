require "rails_helper"

RSpec.describe Communities::UpdateTag do
  describe ".call" do
    it "updates tag" do
      tag = create(:tag)
      service = described_class.new(
        tag: tag,
        text: "Text"
      )

      service.call

      expect(service.tag.text).to eq("Text")
    end
  end
end
