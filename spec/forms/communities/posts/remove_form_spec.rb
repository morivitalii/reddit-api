require "rails_helper"

RSpec.describe Communities::Posts::RemoveForm do
  describe ".save" do
    it "removes post" do
      form = build_form

      expect(form.post).to receive(:remove!).with(form.user, form.reason)

      form.save
    end
  end

  def build_form
    post = create(:post)
    user = create(:user)

    described_class.new(
      post: post,
      user: user,
      reason: "Reason"
    )
  end
end
