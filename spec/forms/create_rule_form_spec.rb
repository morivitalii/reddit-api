require "rails_helper"

RSpec.describe CreateRuleForm do
  subject { described_class.new(title: title, description: description) }

  let(:title) { "Title" }
  let(:description) { "Description" }

  describe ".save" do
    it "creates rule" do
      subject.save
      result = subject.rule

      expect(result).to have_attributes(title: title, description: description)
    end
  end
end