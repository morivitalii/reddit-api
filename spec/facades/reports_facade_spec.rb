require "rails_helper"

RSpec.describe ReportsFacade do
  subject { described_class }

  let(:user) { create(:user) }
  let(:sub) { create(:sub) }
  let(:context) { Context.new(user, sub) }

  describe ".posts_meta_title" do
    it "returns title" do
      expected_result = "#{sub.title}: #{I18n.t("posts_reports")}"
      result = subject.new(context).posts_meta_title

      expect(result).to eq(expected_result)
    end
  end

  describe ".comments_meta_title" do
    it "returns title" do
      expected_result = "#{sub.title}: #{I18n.t("comments_reports")}"
      result = subject.new(context).comments_meta_title

      expect(result).to eq(expected_result)
    end
  end
end