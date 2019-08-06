require "rails_helper"

RSpec.describe UpdateTagForm do
  subject { described_class }

  let(:tag) { double(:tag, update!: "") }

  describe ".save" do
    before do
      @form = subject.new(tag: tag)
    end

    it "calls .update! on tag" do
      @form.save

      expect(tag).to have_received(:update!).with(any_args).once
    end
  end
end