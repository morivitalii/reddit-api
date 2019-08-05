require "rails_helper"

RSpec.describe ApprovePostService do
  subject { described_class.new(post, user) }

  let(:user) { double(:double) }
  let(:post) { double(:post) }

  describe ".call" do
    it "call .approve! on post" do
      expect(post).to receive(:approve!).with(subject.user).once

      subject.call
    end
  end
end