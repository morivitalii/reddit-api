require "rails_helper"

RSpec.describe Communities::UpdateRule do
  describe ".call" do
    it "updates rule" do
      rule = create(:rule)
      service = described_class.new(
        rule: rule,
        title: "New title",
        description: "New description"
      )

      service.call

      expect(service.rule.title).to eq("New title")
      expect(service.rule.description).to eq("New description")
    end
  end
end
