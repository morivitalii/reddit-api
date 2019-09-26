require "rails_helper"

RSpec.describe Cleanup::BansService do
  subject { described_class }

  describe ".call" do
    it "deletes stale bans" do
      create_pair(:ban)
      create_pair(:stale_ban)

      service = build_cleanup_bans_service

      expect { service.call }.to change { Ban.count }.by(-2)
    end
  end

  def build_cleanup_bans_service
    described_class.new
  end
end
