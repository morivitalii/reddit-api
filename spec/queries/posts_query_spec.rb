require "rails_helper"

RSpec.describe PostsQuery do
  subject { described_class.new }

  describe ".not_moderated" do
    let!(:not_moderated_posts) { [create(:not_moderated_post)] }
    let!(:moderated_posts) { [create(:moderated_post)] }

    it "returns not moderated posts" do
      expected_result = not_moderated_posts
      result = subject.not_moderated.all

      expect(result).to eq(expected_result)
    end
  end

  describe ".filter_by_sub" do
    let!(:sub) { create(:sub) }
    let!(:sub_posts) { [create(:post, sub: sub)] }
    let!(:posts) { [create(:post)] }

    it "returns all posts if sub is nil" do
      expected_result = sub_posts + posts
      result = subject.filter_by_sub(nil).all

      expect(result).to eq(expected_result)
    end

    it "returns posts from given sub" do
      expected_result = sub_posts
      result = subject.filter_by_sub(sub).all

      expect(result).to eq(expected_result)
    end
  end

  describe ".filter_by_date" do
    let!(:new_posts) { [create(:post)] }
    let!(:old_posts) { [create(:post, created_at: 1.day.ago)] }

    it "returns all posts if given date is blank" do
      expected_result = new_posts + old_posts
      result = subject.filter_by_date(nil).all

      expect(result).to eq(expected_result)
    end

    it "returns posts in given date" do
      expected_result = new_posts
      date = 1.hour.ago
      result = subject.filter_by_date(date).all

      expect(result).to eq(expected_result)
    end
  end

  describe ".subs_where_user_is_moderator" do
    let!(:user) { create(:user) }
    let!(:sub) { create(:sub) }
    let!(:sub_moderator) { create(:sub_moderator, user: user, sub: sub) }
    let!(:sub_posts) { [create(:post, sub: sub)] }
    let!(:posts) { [create(:post)] }

    it "returns posts from subs where user is moderator" do
      expected_result = sub_posts
      result = subject.subs_where_user_is_moderator(user).all

      expect(result).to eq(expected_result)
    end
  end
end