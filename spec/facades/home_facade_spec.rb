require "rails_helper"

RSpec.describe HomeFacade do
  subject { described_class }

  let(:user) { create(:user) }
  let(:sub) { create(:user) }
  let(:context) { Context.new(user, sub) }

  describe ".index_meta_title" do
    it "returns title" do
      expected_result = I18n.t("app_name")
      result = subject.new(context).index_meta_title

      expect(result).to eq(expected_result)
    end
  end
end