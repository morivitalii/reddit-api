require "rails_helper"

RSpec.describe DeleteDeletionReasonService do
  subject { described_class }

  describe ".call" do
    let!(:deletion_reason) { create(:deletion_reason) }

    before do
      @service = subject.new(deletion_reason)
    end

    it "delete deletion reason" do
      expect { @service.call }.to change { DeletionReason.count }.by(-1)
    end
  end
end