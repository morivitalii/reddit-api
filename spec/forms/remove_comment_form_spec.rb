require "rails_helper"

RSpec.describe RemoveCommentForm do
  subject { described_class }

  describe ".save" do
    let(:user) { instance_double(User) }
    let(:comment) { instance_double(Comment) }
    let(:reason) { "Reason" }

    before do
      @form = subject.new(
        comment: comment,
        user: user,
        reason: reason
      )
    end

    it "call .remove! on comment with args" do
      expect(comment).to receive(:remove!).with(user, reason).once

      @form.save
    end
  end
end