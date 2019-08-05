require "rails_helper"

RSpec.describe DeletePostForm do
  subject { described_class.new(post: post, current_user: user, deletion_reason: "Reason") }

  let(:user) { double(:user) }
  let(:post) { double(:post) }

  describe ".save" do
    it "call .remove! on post with args" do
      expect(post).to receive(:remove!).with(subject.current_user, subject.deletion_reason).once

      subject.save
    end
  end
end