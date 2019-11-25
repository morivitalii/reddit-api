require "rails_helper"

RSpec.describe Communities::DeleteModeratorService do
  describe ".call" do
    it "deletes moderator" do
      service = build_delete_moderator_service

      expect { service.call }.to change { Moderator.count }.by(-1)
    end
  end

  def build_delete_moderator_service
    moderator = create(:moderator)

    described_class.new(moderator)
  end
end
