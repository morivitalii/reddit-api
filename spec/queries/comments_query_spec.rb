require "rails_helper"

RSpec.describe CommentsQuery do
  subject { described_class }

  describe ".not_moderated" do
    it "returns not moderated comments" do
      not_moderated_comments = create_pair(:not_moderated_comment)
      create_pair(:moderated_comment)

      result = subject.new.not_moderated

      expect(result).to match_array(not_moderated_comments)
    end
  end

  describe ".not_removed" do
    it "returns not removed comments" do
      not_removed_comments = create_pair(:comment)
      create_pair(:removed_comment)

      result = subject.new.not_removed

      expect(result).to match_array(not_removed_comments)
    end
  end

  describe ".reported" do
    it "returns comments that have reports" do
      comments_with_reports = create_pair(:comment_with_reports, reports_count: 1)
      create_pair(:comment)

      result = subject.new.reported

      expect(result).to match_array(comments_with_reports)
    end
  end

  describe ".created_after" do
    it "returns comments created after given datetime" do
      datetime = Time.current
      after_datetime = datetime + 1.hour
      before_datetime = datetime - 1.hour

      comments_created_after = create_pair(:comment, created_at: after_datetime)
      create_pair(:comment, created_at: before_datetime)

      result = subject.new.created_after(datetime)

      expect(result).to match_array(comments_created_after)
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
    it "returns comments that bookmarked by given user" do
      user = create(:user)
      comments_bookmarked_by_user = create_pair(:comment_with_bookmark, bookmarked_by: user)
      _other_bookmarked_comments = create_pair(:comment_with_bookmark)

      result = described_class.new.bookmarked_by_user(user)

      expect(result).to match_array(comments_bookmarked_by_user)
    end
  end

  describe ".voted_by_user" do
    it "returns comments that voted by given user" do
      user = create(:user)
      comments_voted_by_user = create_pair(:comment_with_vote, voted_by: user)
      _other_voted_comments = create_pair(:comment_with_vote)

      result = described_class.new.voted_by_user(user)

      expect(result).to match_array(comments_voted_by_user)
    end
  end

  describe ".up_voted_by_user" do
    it "returns comments that up voted by given user" do
      user = create(:user)
      comments_up_voted_by_user = create_pair(:comment_with_up_vote, voted_by: user)
      _comments_down_voted_by_user = create_pair(:comment_with_down_vote, voted_by: user)
      _other_voted_comments = create_pair(:comment_with_vote)

      result = described_class.new.up_voted_by_user(user)

      expect(result).to match_array(comments_up_voted_by_user)
    end
  end

  describe ".down_voted_by_user" do
    it "returns comments that down voted by given user" do
      user = create(:user)
      comments_down_voted_by_user = create_pair(:comment_with_down_vote, voted_by: user)
      _comments_up_voted_by_user = create_pair(:comment_with_up_vote, voted_by: user)
      _other_voted_comments = create_pair(:comment_with_vote)

      result = described_class.new.down_voted_by_user(user)

      expect(result).to match_array(comments_down_voted_by_user)
    end
  end
end
