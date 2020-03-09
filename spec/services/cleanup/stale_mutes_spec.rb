require "rails_helper"

RSpec.describe Cleanup::StaleMutes do
  describe ".call" do
    it "deletes stale mutes" do
      create_pair(:mute)
      create_pair(:stale_mute)
      service = described_class.new

      service.call

      expect(Mute.count).to eq(2)
    end
  end
end
