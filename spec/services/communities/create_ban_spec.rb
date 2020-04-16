require "rails_helper"

RSpec.describe Communities::CreateBan do
  describe ".call" do
    it "creates ban" do
      community = create(:community)
      user = create(:user)

      service = described_class.new(
        community: community,
        user_id: user.id,
        permanent: true
      )

      service.call

      expect(Ban.count).to eq(1)
    end
  end
end
