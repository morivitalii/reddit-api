require "rails_helper"

RSpec.describe UpdateDeletionReasonForm do
  subject { described_class }

  describe ".save" do
    let(:deletion_reason) { instance_double(DeletionReason, update!: "") }

    before do
      @form = subject.new(deletion_reason: deletion_reason)
    end

    it "calls .update! on deletion reason" do
      @form.save

      expect(deletion_reason).to have_received(:update!).with(any_args).once
    end
  end
end