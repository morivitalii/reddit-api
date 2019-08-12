require "rails_helper"

RSpec.describe UpdateRuleForm do
  subject { described_class }

  describe ".save" do
    let(:rule) { instance_double(Rule, update!: "") }

    before do
      @form = subject.new(rule: rule)
    end

    it "calls .update! on rule" do
      @form.save

      expect(rule).to have_received(:update!).with(any_args).once
    end
  end
end