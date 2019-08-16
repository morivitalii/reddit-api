require "rails_helper"

RSpec.describe CommentsQuery do
  subject { described_class }

  describe ".not_moderated" do
    it "returns not moderated comments" do
      not_moderated_comments = create_pair(:not_moderated_comment)
      create_pair(:moderated_comment)

      result = subject.new.not_moderated

      expect(result).to contain_exactly(*not_moderated_comments)
    end
  end

  describe ".reported" do
    it "returns comments that have reports" do
      comments_with_reports = create_pair(:comment_with_reports, reports_count: 1)
      create_pair(:comment)

      result = subject.new.reported

      expect(result).to contain_exactly(*comments_with_reports)
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

      expect(result).to contain_exactly(*comments_created_after)
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