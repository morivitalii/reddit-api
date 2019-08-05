require "rails_helper"

RSpec.describe SubsFacade do
  subject { described_class }

  let(:user) { create(:user) }
  let(:sub) { create(:sub) }
  let(:context) { Context.new(user, sub) }

  describe ".show_meta_title" do
    it "returns title" do
      expected_result = sub.title
      result = subject.new(context).show_meta_title

      expect(result).to eq(expected_result)
    end
  end

  describe ".edit_meta_title" do
    it "returns title" do
      expected_result = "#{sub.title}: #{I18n.t("settings")}"
      result = subject.new(context).edit_meta_title

      expect(result).to eq(expected_result)
    end
  end
end