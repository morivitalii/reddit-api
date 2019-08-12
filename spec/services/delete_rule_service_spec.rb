require "rails_helper"

RSpec.describe DeleteRuleService do
  subject { described_class }

  describe ".call" do
    let!(:rule) { create(:rule) }

    before do
      @service = subject.new(rule)
    end

    it "delete rule" do
      expect { @service.call }.to change { Rule.count }.by(-1)
    end
  end
end