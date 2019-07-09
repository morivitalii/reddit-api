# frozen_string_literal: true

require "rails_helper"

RSpec.describe UserNotModeratorValidator do
  let(:sub) { create(:sub) }
  let(:moderator) { create(:moderator, sub: sub) }
  let(:model) { CreateModerator.new(sub: sub) }
  subject { described_class.new(attributes: [:username]) }

  it "valid if user not moderator in sub" do
    subject.validate_each(model, :username, "username")
    expect(model.errors[:username]).to be_empty
  end

  it "invalid if user moderator in sub" do
    subject.validate_each(model, :username, moderator.user.username)
    expect(model.errors[:username]).to include("пользователь модератор")
  end
end