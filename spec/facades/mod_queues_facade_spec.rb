require "rails_helper"

RSpec.describe ModQueuesFacade do
  subject { described_class }

  let(:user) { create(:user) }
  let(:community) { create(:community) }
  let(:context) { Context.new(user, community) }

  describe ".posts_meta_title" do
    it "returns title" do
      expected_result = "#{community.title}: #{I18n.t("posts_mod_queue")}"
      result = subject.new(context).posts_meta_title

      expect(result).to eq(expected_result)
    end
  end

  describe ".comments_meta_title" do
    it "returns title" do
      expected_result = "#{community.title}: #{I18n.t("comments_mod_queue")}"
      result = subject.new(context).comments_meta_title

      expect(result).to eq(expected_result)
    end
  end
end