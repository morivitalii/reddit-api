RSpec.shared_context "as muted user" do
  before(:each, type: :request) do
    login_as(context.user)
  end

  let(:context) do
    user = create(:user)
    community = create(:community_with_muted_user, user: user)

    Context.new(user, community)
  end
end

RSpec.configure do |config|
  config.include_context "as muted user", context: :as_muted_user
end
