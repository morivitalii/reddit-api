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
end
