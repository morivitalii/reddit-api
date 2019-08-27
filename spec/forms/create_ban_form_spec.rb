require "rails_helper"

RSpec.describe CreateBanForm, type: :form do
  it { expect(described_class.new).to_not be_persisted }

  describe ".save" do
    it "creates ban" do
      form = build_create_ban_form

      expect { form.save }.to change { Ban.count }.by(1)
    end
  end

  def build_create_ban_form
    community = create(:community)
    user = create(:user)

    described_class.new(
      community: community,
      username: user.username,
      permanent: true
    )
  end
end