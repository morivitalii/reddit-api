require "rails_helper"

RSpec.describe Communities::Posts::RemoveComment do
  describe ".call" do
    it "removes comment" do
      comment = create(:comment)
      user = create(:user)
      service = described_class.new(
        comment: comment,
        user: user,
        reason: "Reason"
      )

      service.call

      expect(service.comment.removed_by).to eq(user)
      expect(service.comment.removed_at).to be_present
      expect(service.comment.removed_reason).to eq("Reason")
    end
  end
end
