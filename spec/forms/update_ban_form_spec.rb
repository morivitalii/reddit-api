require "rails_helper"

RSpec.describe UpdateBanForm do
  subject { described_class }

  let(:ban) { double(:ban, update!: "") }

  describe ".save" do
    before do
      @form = subject.new(ban: ban)
    end

    it "calls .update! on ban" do
      @form.save

      expect(ban).to have_received(:update!).with(any_args).once
    end
  end
end