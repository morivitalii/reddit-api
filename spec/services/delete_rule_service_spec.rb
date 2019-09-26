require "rails_helper"

RSpec.describe DeleteRuleService do
  subject { described_class }

  describe ".call" do
    it "deletes rule" do
      service = build_delete_rule_service

      expect { service.call }.to change { Rule.count }.by(-1)
    end
  end

  def build_delete_rule_service
    rule = create(:rule)

    described_class.new(rule)
  end
end
