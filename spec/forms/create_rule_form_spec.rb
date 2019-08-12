require "rails_helper"

RSpec.describe CreateRuleForm do
  subject { described_class }

  describe ".save" do
    let(:sub) { create(:sub) }
    let(:title) { "Title" }
    let(:description) { "Description" }

    before do
      @form = subject.new(
        sub: sub,
        title: title,
        description: description
      )
    end

    it "creates rule" do
      @form.save
      result = @form.rule

      expect(result).to have_attributes(sub: sub, title: title, description: description)
    end
  end
end