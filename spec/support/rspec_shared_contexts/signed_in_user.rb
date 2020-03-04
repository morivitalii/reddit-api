RSpec.shared_context "as signed in user" do
  before(:each, type: :request) do
    login_as(context.user)
  end

  let(:context) do
    user = create(:user)

    Context.new(user, nil)
  end
end

RSpec.configure do |config|
  config.include_context "as signed in user", context: :as_signed_in_user
end
