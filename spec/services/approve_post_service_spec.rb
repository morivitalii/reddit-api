require "rails_helper"

RSpec.describe ApprovePostService do
  subject { described_class }

  describe ".call" do
    let(:user) { instance_double(User) }
    let(:post) { instance_double(Post) }

    before do
      @service = subject.new(post, user)
    end

    it "call .approve! on post" do
      expect(post).to receive(:approve!).with(user).once

      @service.call
    end
  end
end