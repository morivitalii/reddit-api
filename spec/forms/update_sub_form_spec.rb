require "rails_helper"

RSpec.describe UpdateSubForm do
  subject { described_class }

  let(:sub) { double(:sub, update!: "") }

  describe ".save" do
    before do
      @form = subject.new(sub: sub)
    end

    it "calls .update! on sub" do
      @form.save

      expect(sub).to have_received(:update!).with(any_args).once
    end
  end
end