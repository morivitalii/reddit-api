require "rails_helper"

RSpec.describe ModQueuesFacade do
  subject { described_class.new(context) }

  let(:user) { create(:user) }

  describe ".index_meta_title" do
    context "global" do
      let(:context) { Context.new(user) }

      it "returns title" do
        expected_result = I18n.t("mod_queue")
        result = subject.index_meta_title

        expect(result).to eq(expected_result)
      end
    end

    context "sub" do
      let(:sub) { create(:sub) }
      let(:context) { Context.new(user, sub) }

      it "returns title" do
        expected_result = "#{sub.title}: #{I18n.t("mod_queue")}"
        result = subject.index_meta_title

        expect(result).to eq(expected_result)
      end
    end
  end
end