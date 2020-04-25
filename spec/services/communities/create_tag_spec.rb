require "rails_helper"

RSpec.describe Communities::CreateTag do
  describe ".call" do
    it "creates tag" do
      community = create(:community)
      service = described_class.new(
        community: community,
        text: "Text"
      )

      service.call

      expect(Tag.count).to eq(1)
    end
  end
end
