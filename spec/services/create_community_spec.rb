require "rails_helper"

RSpec.describe CreateCommunity do
  describe ".call" do
    it "creates community with moderator" do
      user = create(:user)
      service = described_class.new(
        user: user,
        url: "Url",
        title: "Title",
        description: "Description"
      )

      service.call

      expect(Community.count).to eq(1)
      expect(service.community.moderators.count).to eq(1)
      expect(service.community.url).to eq("Url")
      expect(service.community.title).to eq("Title")
      expect(service.community.description).to eq("Description")
    end
  end
end
