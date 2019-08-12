require "rails_helper"

RSpec.describe UpdateSubForm do
  subject { described_class }

  describe ".save" do
    let(:sub) { instance_double(Sub, update!: "") }

    before do
      @form = subject.new(sub: sub)
    end

    it "calls .update! on sub" do
      @form.save

      expect(sub).to have_received(:update!).with(any_args).once
    end
  end
end