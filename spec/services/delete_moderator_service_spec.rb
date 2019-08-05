require "rails_helper"

RSpec.describe DeleteModeratorService do
  subject { described_class.new(moderator) }

  let!(:moderator) { create(:moderator) }

  describe ".call" do
    it "delete moderator" do
      expect { subject.call }.to change { Moderator.count }.by(-1)
    end
  end
end