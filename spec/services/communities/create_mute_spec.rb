require "rails_helper"

RSpec.describe Communities::CreateMute do
  describe ".call" do
    it "creates mute" do
      community = create(:community)
      user = create(:user)

      service = described_class.new(
        community: community,
        username:  user.username,
        permanent: true
      )

      service.call

      expect(Mute.count).to eq(1)
    end
  end
end
