require "rails_helper"

RSpec.describe CreateBanForm, type: :form do
  subject { described_class }

  describe ".save" do
    it "creates ban" do
      community = create(:community)
      user = create(:user)
      permanent = true

      form = subject.new(
        community: community,
        username: user.username,
        permanent: permanent
      )

      form.save

      expect(form.ban).to be_persisted
      expect(form.ban).to have_attributes(community: community, user: user, permanent: permanent)
    end
  end
end