RSpec.shared_context "user context" do
  let(:context) do
    user = create(:user)
    community = create(:community)

    Context.new(user, community)
  end
end