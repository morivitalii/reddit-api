RSpec.shared_context "visitor context" do
  let(:context) do
    user = nil
    community = create(:community)

    Context.new(user, community)
  end
end

RSpec.configure do |config|
  config.include_context "visitor context", context: :visitor
end