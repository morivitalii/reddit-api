require "rails_helper"

RSpec.describe Communities::UpdatePost do
  describe ".call" do
    it "updates post" do
      post = create(:text_post)
      user = create(:user)
      service = described_class.new(post: post, edited_by: user, text: "Text")

      service.call

      expect(service.post.text).to eq(service.text)
      expect(service.post.edited_by).to eq(user)
      expect(service.post.edited_at).to be_present
    end
  end
end
