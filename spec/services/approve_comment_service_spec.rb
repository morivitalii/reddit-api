require "rails_helper"

RSpec.describe ApproveCommentService do
  subject { described_class.new(comment, user) }

  let(:user) { double(:double) }
  let(:comment) { double(:comment) }

  describe ".call" do
    it "call .approve! on comment" do
      expect(comment).to receive(:approve!).with(subject.user).once

      subject.call
    end
  end
end