require "rails_helper"

RSpec.describe Communities::DeleteBan do
  describe ".call" do
    it "deletes ban" do
      ban = create(:ban)
      service = described_class.new(ban: ban)

      service.call

      expect(Ban.count).to eq(0)
    end
  end
end
