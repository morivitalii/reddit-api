require "rails_helper"

RSpec.describe "User signs out" do
  it "successfully" do
    user = create(:user)

    sign_in_as(user)
    sign_out_as(user)

    expect(page).to_not have_signed_in_user(user)
  end
end