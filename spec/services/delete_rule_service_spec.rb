require "rails_helper"

RSpec.describe DeleteRuleService do
  subject { described_class.new(rule) }

  let!(:rule) { create(:rule) }

  describe ".call" do
    it "delete blacklisted domain" do
      expect { subject.call }.to change { Rule.count }.by(-1)
    end
  end
end