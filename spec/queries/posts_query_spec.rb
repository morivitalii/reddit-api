require "rails_helper"

RSpec.describe PostsQuery do
  subject { described_class }

  describe ".not_moderated" do
    it "returns not moderated posts" do
      not_moderated = create_pair(:not_moderated_post)
      create_pair(:moderated_post)

      result = subject.new.not_moderated

      expect(result).to match_array(not_moderated)
    end
  end

  describe ".not_removed" do
    it "returns not removed posts" do
      not_removed_posts = create_pair(:post)
      create_pair(:removed_post)

      result = subject.new.not_removed

      expect(result).to match_array(not_removed_posts)
    end
  end

  describe ".reported" do
    it "returns posts that have reports" do
      posts_with_reports = create_pair(:post_with_reports, reports_count: 1)
      create_pair(:post)

      result = subject.new.reported

      expect(result).to match_array(posts_with_reports)
    end
  end

  describe ".for_the_last_day" do
    it "returns posts created for the last day" do
      posts_created_for_the_last_day = create_pair(:post)
      _other_posts = create_pair(:post, created_at: 1.week.ago)

      result = subject.new.for_the_last_day

      expect(result).to match_array(posts_created_for_the_last_day)
    end
  end

  describe ".for_the_last_week" do
    it "returns posts created for the last week" do
      posts_created_for_the_last_week = create_pair(:post)
      _other_posts = create_pair(:post, created_at: 1.month.ago)

      result = subject.new.for_the_last_week

      expect(result).to match_array(posts_created_for_the_last_week)
    end
  end

  describe ".created_after" do
    it "returns posts created after given datetime" do
      datetime = Time.current
      after_datetime = datetime + 1.hour
      before_datetime = datetime - 1.hour

      posts_created_after = create_pair(:post, created_at: after_datetime)
      create_pair(:post, created_at: before_datetime)

      result = subject.new.created_after(datetime)

      expect(result).to match_array(posts_created_after)
    end
  end

  describe ".search_created_after" do
    it "returns relation if datetime is blank" do
      query = subject.new

      result = query.search_created_after(nil)

      expect(result).to eq(query.relation)
    end

    it "calls .created_after if datetime is present" do
      datetime = Time.current
      query = subject.new
      allow(query).to receive(:created_after)

      query.search_created_after(datetime)

      expect(query).to have_received(:created_after).with(datetime)
    end
  end

  describe ".bookmarked_by_user" do
    it "returns posts that bookmarked by given user" do
      user = create(:user)
      posts_bookmarked_by_user = create_pair(:post_with_bookmark, bookmarked_by: user)
      _other_bookmarked_posts = create_pair(:post_with_bookmark)

      result = described_class.new.bookmarked_by_user(user)

      expect(result).to match_array(posts_bookmarked_by_user)
    end
  end

  describe ".voted_by_user" do
    it "returns posts that voted by given user" do
      user = create(:user)
      posts_voted_by_user = create_pair(:post_with_vote, voted_by: user)
      _other_voted_posts = create_pair(:post_with_vote)

      result = described_class.new.voted_by_user(user)

      expect(result).to match_array(posts_voted_by_user)
    end
  end

  describe ".up_voted_by_user" do
    it "returns posts that up voted by given user" do
      user = create(:user)
      posts_up_voted_by_user = create_pair(:post_with_up_vote, voted_by: user)
      _posts_down_voted_by_user = create_pair(:post_with_down_vote, voted_by: user)
      _other_voted_posts = create_pair(:post_with_vote)

      result = described_class.new.up_voted_by_user(user)

      expect(result).to match_array(posts_up_voted_by_user)
    end
  end

  describe ".down_voted_by_user" do
    it "returns posts that down voted by given user" do
      user = create(:user)
      posts_down_voted_by_user = create_pair(:post_with_down_vote, voted_by: user)
      _posts_up_voted_by_user = create_pair(:post_with_up_vote, voted_by: user)
      _other_voted_posts = create_pair(:post_with_vote)

      result = described_class.new.down_voted_by_user(user)

      expect(result).to match_array(posts_down_voted_by_user)
    end
  end
end
