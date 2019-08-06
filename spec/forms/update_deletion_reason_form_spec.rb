require "rails_helper"

RSpec.describe UpdateDeletionReasonForm do
  subject { described_class }

  let(:deletion_reason) { double(:deletion_reason, update!: "") }

  describe ".save" do
    before do
      @form = subject.new(deletion_reason: deletion_reason)
    end

    it "calls .update! on deletion reason" do
      @form.save

      expect(deletion_reason).to have_received(:update!).with(any_args).once
    end
  end
end