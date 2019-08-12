require "rails_helper"

RSpec.describe DeleteModeratorService do
  subject { described_class }

  describe ".call" do
    let!(:moderator) { create(:moderator) }

    before do
      @service = subject.new(moderator)
    end

    it "delete moderator" do
      expect { @service.call }.to change { Moderator.count }.by(-1)
    end
  end
end