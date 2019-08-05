require "rails_helper"

RSpec.describe Cleanup::BansService do
  subject { described_class.new }

  let!(:stale_ban) { create(:ban, :stale) }

  describe ".call" do
    it "delete stale bans" do
      expect { subject.call }.to change { Ban.count }.by(-1)
    end
  end
end