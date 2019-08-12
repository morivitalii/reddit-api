require "rails_helper"

RSpec.describe DeleteBanService do
  subject { described_class }

  describe ".call" do
    let!(:ban) { create(:ban) }

    before do
      @service = subject.new(ban)
    end

    it "delete ban" do
      expect { @service.call }.to change { Ban.count }.by(-1)
    end
  end
end