require "rails_helper"

RSpec.describe UpdateBanForm, type: :form do
  subject { described_class }

  describe ".save" do
    it "updates ban" do
      ban = instance_double(Ban)
      form = subject.new(ban: ban)

      expect(ban).to receive(:update!).with(any_args).once

      form.save
    end
  end
end