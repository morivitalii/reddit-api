RSpec.shared_context "moderator context" do
  let(:context) do
    user = create(:user)
    community = create(:community_with_user_moderator, user: user)

    Context.new(user, community)
  end
end

RSpec.configure do |config|
  config.include_context "moderator context", context: :moderator
end