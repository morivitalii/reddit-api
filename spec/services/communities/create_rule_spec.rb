require "rails_helper"

RSpec.describe Communities::CreateRule do
  describe ".call" do
    it "creates rule" do
      community = create(:community)
      service = described_class.new(
        community: community,
        title: "Title",
        description: "Description"
      )

      service.call

      expect(Rule.count).to eq(1)
    end
  end
end
