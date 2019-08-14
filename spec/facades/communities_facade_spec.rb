require "rails_helper"

RSpec.describe CommunitiesFacade do
  subject { described_class }

  let(:user) { create(:user) }
  let(:community) { create(:community) }
  let(:context) { Context.new(user, community) }

  describe ".show_meta_title" do
    it "returns title" do
      expected_result = community.title
      result = subject.new(context).show_meta_title

      expect(result).to eq(expected_result)
    end
  end

  describe ".edit_meta_title" do
    it "returns title" do
      expected_result = "#{community.title}: #{I18n.t("settings")}"
      result = subject.new(context).edit_meta_title

      expect(result).to eq(expected_result)
    end
  end
end