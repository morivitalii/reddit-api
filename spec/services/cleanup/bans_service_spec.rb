require "rails_helper"

RSpec.describe Cleanup::BansService do
  subject { described_class }

  describe ".call" do
    let!(:stale_ban) { create(:ban, :stale) }

    before do
      @service = subject.new
    end

    it "delete stale bans" do
      expect { @service.call }.to change { Ban.count }.by(-1)
    end
  end
end