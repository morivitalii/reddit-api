require "rails_helper"

RSpec.describe DeletionReasonsFacade do
  subject { described_class }

  let(:user) { create(:user) }
  let(:sub) { create(:sub) }
  let(:global_context) { Context.new(user) }
  let(:sub_context) { Context.new(user, sub) }

  describe ".index_meta_title" do
    context "global" do
      it "returns title" do
        expected_result = I18n.t("deletion_reasons")
        result = subject.new(global_context).index_meta_title

        expect(result).to eq(expected_result)
      end
    end

    context "sub" do
      it "returns title" do
        expected_result = "#{sub.title}: #{I18n.t("deletion_reasons")}"
        result = subject.new(sub_context).index_meta_title

        expect(result).to eq(expected_result)
      end
    end
  end
end