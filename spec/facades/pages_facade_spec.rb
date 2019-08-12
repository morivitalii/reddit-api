require "rails_helper"

RSpec.describe PagesFacade do
  subject { described_class }

  let(:user) { create(:user) }
  let(:sub) { create(:sub) }
  let(:context) { Context.new(user, sub) }
  let(:page) { create(:page, sub: sub) }

  describe ".index_meta_title" do
    it "returns title" do
      expected_result = "#{sub.title}: #{I18n.t("pages")}"
      result = subject.new(context).index_meta_title

      expect(result).to eq(expected_result)
    end
  end

  describe ".show_meta_title" do
    it "returns title" do
      expected_result = "#{sub.title}: #{page.title}"
      result = subject.new(context, page).show_meta_title

      expect(result).to eq(expected_result)
    end
  end

  describe ".new_meta_title" do
    it "returns title" do
      expected_result = "#{sub.title}: #{I18n.t("pages")}"
      result = subject.new(context).new_meta_title

      expect(result).to eq(expected_result)
    end
  end

  describe ".edit_meta_title" do
    it "returns title" do
      expected_result = "#{sub.title}: #{page.title}"
      result = subject.new(context, page).edit_meta_title

      expect(result).to eq(expected_result)
    end
  end
end