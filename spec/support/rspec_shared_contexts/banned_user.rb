RSpec.shared_context "as banned user" do
  before do
    login_as(user_context.user)
  end

  let(:user_context) do
    user = create(:user)
    community = create(:community_with_banned_user, user: user)

    Context.new(user, community)
  end
end

RSpec.configure do |config|
  config.include_context "as banned user", context: :as_banned_user
end
