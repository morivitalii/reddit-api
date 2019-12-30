require "rails_helper"

RSpec.describe UpdateCommunity do
  describe ".call" do
    it "updates community" do
      community = create(:community)
      service = described_class.new(
        community: community,
        title: "New title",
        description: "New description"
      )

      service.call

      expect(service.community.title).to eq("New title")
      expect(service.community.description).to eq("New description")
    end
  end
end
