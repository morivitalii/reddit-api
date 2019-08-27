require "rails_helper"

RSpec.describe RemovePostForm, type: :form do
  it { expect(described_class.new).to be_persisted }

  describe ".save" do
    it "removes post" do
      form = build_remove_post_form
      form.save

      post = form.post

      expect(post.removed_by).to eq(form.user)
      expect(post.removed_at).to be_present
      expect(post.removed_reason).to eq(form.reason)
    end
  end

  def build_remove_post_form
    post = create(:post)
    user = create(:user)

    described_class.new(
      post: post,
      user: user,
      reason: "Reason"
    )
  end
end