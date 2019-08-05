require "rails_helper"

RSpec.describe PagesFacade do
  subject { described_class }

  let(:user) { create(:user) }
  let(:sub) { create(:sub) }
  let(:global_context) { Context.new(user) }
  let(:sub_context) { Context.new(user, sub) }
  let(:global_page) { create(:page) }
  let(:sub_page) { create(:sub_page, sub: sub) }

  describe ".index_meta_title" do
    context "global" do
      it "returns title" do
        expected_result = I18n.t("pages")
        result = subject.new(global_context).index_meta_title

        expect(result).to eq(expected_result)
      end
    end

    context "sub" do
      it "returns title" do
        expected_result = "#{sub.title}: #{I18n.t("pages")}"
        result = subject.new(sub_context).index_meta_title

        expect(result).to eq(expected_result)
      end
    end
  end

  describe ".show_meta_title" do
    context "global" do
      it "returns title" do
        expected_result = global_page.title
        result = subject.new(global_context, global_page).show_meta_title

        expect(result).to eq(expected_result)
      end
    end

    context "sub" do
      it "returns title" do
        expected_result = "#{sub.title}: #{sub_page.title}"
        result = subject.new(sub_context, sub_page).show_meta_title

        expect(result).to eq(expected_result)
      end
    end
  end

  describe ".new_meta_title" do
    context "global" do
      it "returns title" do
        expected_result = I18n.t("pages")
        result = subject.new(global_context).new_meta_title

        expect(result).to eq(expected_result)
      end
    end

    context "sub" do
      it "returns title" do
        expected_result = "#{sub.title}: #{I18n.t("pages")}"
        result = subject.new(sub_context).new_meta_title

        expect(result).to eq(expected_result)
      end
    end
  end

  describe ".edit_meta_title" do
    context "global" do
      it "returns title" do
        expected_result = global_page.title
        result = subject.new(global_context, global_page).edit_meta_title

        expect(result).to eq(expected_result)
      end
    end

    context "sub" do
      it "returns title" do
        expected_result = "#{sub.title}: #{sub_page.title}"
        result = subject.new(sub_context, sub_page).edit_meta_title

        expect(result).to eq(expected_result)
      end
    end
  end
end