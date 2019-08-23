RSpec.shared_context "follower context" do
  let(:context) do
    user = create(:user)
    community = create(:community_with_user_follower, user: user)

    Context.new(user, community)
  end
end
