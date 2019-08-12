require "rails_helper"

RSpec.describe ApproveCommentService do
  subject { described_class }

  describe ".call" do
    let(:user) { instance_double(User) }
    let(:comment) { instance_double(Comment) }

    before do
      @service = subject.new(comment, user)
    end

    it "call .approve! on comment" do
      expect(comment).to receive(:approve!).with(user).once

      @service.call
    end
  end
end