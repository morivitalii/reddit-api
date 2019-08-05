require "rails_helper"

RSpec.describe DeleteDeletionReasonService do
  subject { described_class.new(deletion_reason) }

  let!(:deletion_reason) { create(:deletion_reason) }

  describe ".call" do
    it "delete blacklisted domain" do
      expect { subject.call }.to change { DeletionReason.count }.by(-1)
    end
  end
end