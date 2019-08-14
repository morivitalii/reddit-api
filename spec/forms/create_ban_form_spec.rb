require "rails_helper"

RSpec.describe CreateBanForm do
  subject { described_class }

  describe ".save" do
    it "creates ban" do
      sub = create(:sub)
      user = create(:user)
      permanent = true

      form = subject.new(
        sub: sub,
        username: user.username,
        permanent: permanent
      )

      form.save

      expect(form.ban).to be_persisted
      expect(form.ban).to have_attributes(sub: sub, user: user, permanent: permanent)
    end
  end
end