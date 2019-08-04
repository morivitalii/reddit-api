require "rails_helper"

RSpec.describe PagesFacade do
  subject { described_class.new(context, page) }

  let(:user) { create(:user) }
  let(:sub) { create(:sub) }
  let(:page) { create(:page) }

  describe ".index_meta_title" do
    context "global" do
      let(:context) { Context.new(user) }

      it "returns title" do
        expected_result = I18n.t("pages")
        result = subject.index_meta_title

        expect(result).to eq(expected_result)
      end
    end

    context "sub" do
      let(:context) { Context.new(user, sub) }

      it "returns title" do
        expected_result = "#{sub.title}: #{I18n.t("pages")}"
        result = subject.index_meta_title

        expect(result).to eq(expected_result)
      end
    end
  end

  describe ".show_meta_title" do
    context "global" do
      let(:context) { Context.new(user) }

      it "returns title" do
        expected_result = page.title
        result = subject.show_meta_title

        expect(result).to eq(expected_result)
      end
    end

    context "sub" do
      let(:context) { Context.new(user, sub) }

      it "returns title" do
        expected_result = "#{sub.title}: #{page.title}"
        result = subject.show_meta_title

        expect(result).to eq(expected_result)
      end
    end
  end

  describe ".new_meta_title" do
    context "global" do
      let(:context) { Context.new(user) }

      it "returns title" do
        expected_result = I18n.t("pages")
        result = subject.new_meta_title

        expect(result).to eq(expected_result)
      end
    end

    context "sub" do
      let(:context) { Context.new(user, sub) }

      it "returns title" do
        expected_result = "#{sub.title}: #{I18n.t("pages")}"
        result = subject.new_meta_title

        expect(result).to eq(expected_result)
      end
    end
  end

  describe ".edit_meta_title" do
    context "global" do
      let(:context) { Context.new(user) }

      it "returns title" do
        expected_result = page.title
        result = subject.edit_meta_title

        expect(result).to eq(expected_result)
      end
    end

    context "sub" do
      let(:context) { Context.new(user, sub) }

      it "returns title" do
        expected_result = "#{sub.title}: #{page.title}"
        result = subject.edit_meta_title

        expect(result).to eq(expected_result)
      end
    end
  end
end