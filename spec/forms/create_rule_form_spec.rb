require "rails_helper"

RSpec.describe CreateRuleForm, type: :form do
  subject { described_class }

  describe ".save" do
    let(:community) { create(:community) }
    let(:title) { "Title" }
    let(:description) { "Description" }

    before do
      @form = subject.new(
        community: community,
        title: title,
        description: description
      )
    end

    it "creates rule" do
      @form.save
      result = @form.rule

      expect(result).to have_attributes(community: community, title: title, description: description)
    end
  end
end