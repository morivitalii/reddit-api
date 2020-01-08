require "rails_helper"

RSpec.describe Cleanup::StaleBans do
  describe ".call" do
    it "deletes stale bans" do
      create_pair(:ban)
      create_pair(:stale_ban)
      service = described_class.new

      service.call

      expect(Ban.count).to eq(2)
    end
  end
end
