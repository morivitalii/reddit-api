RSpec.shared_context "as banned user" do
  before(:each, type: :request) do
    login_as(context.user)
  end

  let(:context) do
    user = create(:user)
    community = create(:community_with_banned_user, user: user)

    Context.new(user, community)
  end
end

RSpec.configure do |config|
  config.include_context "as banned user", context: :as_banned_user
end
