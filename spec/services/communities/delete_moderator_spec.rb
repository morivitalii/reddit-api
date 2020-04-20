require "rails_helper"

RSpec.describe Communities::DeleteModerator do
  describe ".call" do
    it "deletes moderator" do
      moderator = create(:moderator)
      service = described_class.new(moderator: moderator)

      service.call

      expect(Moderator.count).to eq(0)
    end
  end
end
