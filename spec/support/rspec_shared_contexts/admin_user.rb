RSpec.shared_context "as admin user" do
  before(:each, type: :request) do
    login_as(context.user)
  end

  let(:context) do
    user = create(:user)
    create(:admin, user: user)

    Context.new(user, nil)
  end
end

RSpec.configure do |config|
  config.include_context "as admin user", context: :as_admin_user
end
