RSpec.shared_context "as exiled user" do
  before(:each, type: :request) do
    login_as(context.user)
  end

  let(:context) do
    user = create(:user)
    create(:exile, user: user)

    Context.new(user, nil)
  end
end

RSpec.configure do |config|
  config.include_context "as exiled user", context: :as_exiled_user
end
