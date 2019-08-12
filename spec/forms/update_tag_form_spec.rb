require "rails_helper"

RSpec.describe UpdateTagForm do
  subject { described_class }

  describe ".save" do
    let(:tag) { instance_double(Tag, update!: "") }

    before do
      @form = subject.new(tag: tag)
    end

    it "calls .update! on tag" do
      @form.save

      expect(tag).to have_received(:update!).with(any_args).once
    end
  end
end