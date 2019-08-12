require "rails_helper"

RSpec.describe ContributorsFacade do
  subject { described_class }

  let(:user) { create(:user) }
  let(:sub) { create(:sub) }
  let(:context) { Context.new(user, sub) }

  describe ".index_meta_title" do
    it "returns title" do
      expected_result = "#{sub.title}: #{I18n.t("contributors")}"
      result = subject.new(context).index_meta_title

      expect(result).to eq(expected_result)
    end
  end
end