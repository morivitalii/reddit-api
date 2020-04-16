require "rails_helper"

RSpec.describe CreateExile do
  describe ".call" do
    it "creates exile" do
      user = create(:user)

      service = described_class.new(
        user_id: user.id
      )

      service.call

      expect(Exile.count).to eq(1)
    end
  end
end