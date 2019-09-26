require "rails_helper"

RSpec.describe DeleteModeratorService do
  subject { described_class }

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
