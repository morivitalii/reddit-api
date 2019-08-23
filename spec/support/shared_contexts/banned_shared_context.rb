RSpec.shared_context "banned context" do
  let(:context) do
    user = create(:user)
    community = create(:community_with_banned_user, user: user)

    Context.new(user, community)
  end
end