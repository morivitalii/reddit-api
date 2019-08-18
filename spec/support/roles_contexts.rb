RSpec.shared_context "default context" do
  let(:context) do
    build_default_context
  end
end

RSpec.shared_context "visitor context" do
  let(:context) do
    build_visitor_context
  end
end

RSpec.shared_context "user context" do
  let(:context) do
    build_user_context
  end
end

RSpec.shared_context "moderator context" do
  let(:context) do
    build_moderator_context
  end
end

RSpec.shared_context "follower context" do
  let(:context) do
    build_follower_context
  end
end

RSpec.shared_context "banned context" do
  let(:context) do
    build_banned_context
  end
end