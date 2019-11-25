require "rails_helper"

RSpec.describe Communities::CreateBanForm do
  describe ".save" do
    it "creates ban" do
      form = build_form

      expect { form.save }.to change { Ban.count }.by(1)
    end
  end

  def build_form
    community = create(:community)
    user = create(:user)

    described_class.new(
      community: community,
      username: user.username,
      permanent: true
    )
  end
end
