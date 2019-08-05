require "rails_helper"

RSpec.describe DeleteBanService do
  subject { described_class.new(ban) }

  let!(:ban) { create(:ban) }

  describe ".call" do
    it "delete ban" do
      expect { subject.call }.to change { Ban.count }.by(-1)
    end
  end
end