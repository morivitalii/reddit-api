require "rails_helper"

RSpec.describe UpdateBanForm, type: :form do
  it { expect(described_class.new).to be_persisted }

  describe ".save" do
    it "updates ban" do
      form = build_update_ban_from

      form.save

      ban = form.ban
      expect(ban.reason).to eq(form.reason)
      expect(ban.days).to eq(form.days)
      expect(ban.permanent).to eq(form.permanent)
    end
  end

  def build_update_ban_from
    ban = create(:ban)

    described_class.new(
      ban: ban,
      reason: "Reason",
      days: 1,
      permanent: false
    )
  end
end