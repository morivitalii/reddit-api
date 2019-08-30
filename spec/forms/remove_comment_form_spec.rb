require "rails_helper"

RSpec.describe RemoveCommentForm do
  it { expect(described_class.new).to be_persisted }

  describe ".save" do
    it "removes comment" do
      form = build_remove_comment_form
      form.save

      comment = form.comment

      expect(comment.removed_by).to eq(form.user)
      expect(comment.removed_at).to be_present
      expect(comment.removed_reason).to eq(form.reason)
    end
  end

  def build_remove_comment_form
    comment = create(:comment)
    user = create(:user)

    described_class.new(
      comment: comment,
      user: user,
      reason: "Reason"
    )
  end
end