require "rails_helper"

RSpec.describe RemoveCommentForm do
  subject { described_class.new(comment: comment, user: user, reason: "Reason") }

  let(:user) { double(:user) }
  let(:comment) { double(:comment) }

  describe ".save" do
    it "call .remove! on comment with args" do
      expect(comment).to receive(:remove!).with(subject.user, subject.reason).once

      subject.save
    end
  end
end