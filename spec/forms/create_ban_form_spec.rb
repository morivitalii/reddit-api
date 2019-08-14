require "rails_helper"

RSpec.describe CreateBanForm do
  subject { described_class }

  describe ".save" do
    it "creates ban" do
      sub = create(:sub)
      user = create(:user)
      banned_by = create(:user)
      permanent = true

      form = subject.new(
        sub: sub,
        banned_by: banned_by,
        username: user.username,
        permanent: permanent
      )

      form.save

      expect(form.ban).to be_persisted
      expect(form.ban).to have_attributes(sub: sub, banned_by: banned_by, user: user, permanent: permanent)
    end
  end
end