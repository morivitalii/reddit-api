require "rails_helper"

RSpec.describe Communities::UpdateRuleForm do
  describe ".save" do
    it "updates rule" do
      form = build_update_rule_form

      form.save

      rule = form.rule
      expect(rule.title).to eq(form.title)
      expect(rule.description).to eq(form.description)
    end
  end

  def build_update_rule_form
    rule = create(:rule)

    described_class.new(
      rule: rule,
      title: "Title",
      description: "Description"
    )
  end
end
