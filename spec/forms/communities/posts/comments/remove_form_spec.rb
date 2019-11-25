require "rails_helper"

RSpec.describe Communities::Posts::Comments::RemoveForm do
  describe ".save" do
    it "removes comment" do
      form = build_form

      expect(form.comment).to receive(:remove!).with(form.user, form.reason)

      form.save
    end
  end

  def build_form
    comment = create(:comment)
    user = create(:user)

    described_class.new(
      comment: comment,
      user: user,
      reason: "Reason"
    )
  end
end
