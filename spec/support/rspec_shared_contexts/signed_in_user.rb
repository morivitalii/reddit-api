RSpec.shared_context "as signed in user" do
  before(:each, type: :request) do
    login_as(user)
  end

  let(:user) do
    create(:user)
  end
end

RSpec.configure do |config|
  config.include_context "as signed in user", context: :as_signed_in_user
end
