require "rails_helper"

RSpec.describe RemovePostForm, type: :form do
  subject { described_class }

  describe ".save" do
    let(:user) { instance_double(User) }
    let(:post) { instance_double(Post) }
    let(:reason) { "Reason" }

    before do
      @form = subject.new(
        post: post,
        user: user,
        reason: reason
      )
    end

    it "call .remove! on post with args" do
      expect(post).to receive(:remove!).with(user, reason).once

      @form.save
    end
  end
end