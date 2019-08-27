require "rails_helper"

RSpec.describe CreateRuleForm, type: :form do
  it { expect(described_class.new).to_not be_persisted }

  describe ".save" do
    it "creates rule" do
      form = build_create_rule_form

      expect { form.save }.to change { Rule.count }
    end
  end

  def build_create_rule_form
    community = create(:community)

    described_class.new(
      community: community,
      title: "Title",
      description: "Description"
    )
  end
end