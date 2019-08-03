require "rails_helper"

RSpec.describe CommentsQuery do
  subject { described_class.new }

  describe ".not_moderated" do
    let!(:not_moderated_comments) { [create(:not_moderated_comment)] }
    let!(:moderated_comments) { [create(:moderated_comment)] }

    it "returns not moderated comments" do
      expected_result = not_moderated_comments
      result = subject.not_moderated.all

      expect(result).to eq(expected_result)
    end
  end

  describe ".filter_by_sub" do
    let!(:sub) { create(:sub) }
    let!(:sub_post) { create(:post, sub: sub) }
    let!(:sub_comments) { [create(:comment, post: sub_post)] }
    let!(:comments) { [create(:comment)] }

    it "returns all comments if sub is nil" do
      expected_result = sub_comments + comments
      result = subject.filter_by_sub(nil).all

      expect(result).to eq(expected_result)
    end

    it "returns comments from given sub" do
      expected_result = sub_comments
      result = subject.filter_by_sub(sub).all

      expect(result).to eq(expected_result)
    end
  end

  describe ".filter_by_date" do
    let!(:new_comments) { [create(:comment)] }
    let!(:old_comments) { [create(:comment, created_at: 1.day.ago)] }

    it "returns all comments if given date is blank" do
      expected_result = new_comments + old_comments
      result = subject.filter_by_date(nil).all

      expect(result).to eq(expected_result)
    end

    it "returns comments in given date" do
      expected_result = new_comments
      date = 1.hour.ago
      result = subject.filter_by_date(date).all

      expect(result).to eq(expected_result)
    end
  end

  describe ".subs_where_user_is_moderator" do
    let!(:user) { create(:user) }
    let!(:sub) { create(:sub) }
    let!(:sub_moderator) { create(:sub_moderator, user: user, sub: sub) }
    let!(:sub_post) { create(:post, sub: sub) }
    let!(:sub_comments) { [create(:comment, post: sub_post)] }
    let!(:comments) { [create(:comment)] }

    it "returns comments from subs where user is moderator" do
      expected_result = sub_comments
      result = subject.subs_where_user_is_moderator(user).all

      expect(result).to eq(expected_result)
    end
  end
end