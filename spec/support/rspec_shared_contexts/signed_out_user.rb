RSpec.shared_context "as signed out user" do
  before do
    logout
  end

  let(:user) do
    nil
  end
end

RSpec.configure do |config|
  config.include_context "as signed out user", context: :as_signed_out_user
end
