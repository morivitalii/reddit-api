RSpec.shared_context "as signed out user" do
  let(:context) do
    Context.new(nil, nil)
  end
end

RSpec.configure do |config|
  config.include_context "as signed out user", context: :as_signed_out_user
end
