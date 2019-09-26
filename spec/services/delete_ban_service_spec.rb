require "rails_helper"

RSpec.describe DeleteBanService do
  subject { described_class }

  describe ".call" do
    it "deletes ban" do
      service = build_delete_ban_service

      expect { service.call }.to change { Ban.count }.by(-1)
    end
  end

  def build_delete_ban_service
    ban = create(:ban)

    described_class.new(ban)
  end
end
