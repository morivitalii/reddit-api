require "rails_helper"

RSpec.describe CreateModeratorForm do
  it { expect(described_class.new).to_not be_persisted }

  describe ".save" do
    it "creates moderator" do
      form = build_create_moderator_form

      expect { form.save }.to change { Moderator.count }.by(1)
    end
  end

  def build_create_moderator_form
    community = create(:community)
    user = create(:user)

    described_class.new(
      community: community,
      username: user.username
    )
  end
end
