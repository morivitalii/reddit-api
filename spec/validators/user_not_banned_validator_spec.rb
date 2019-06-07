# frozen_string_literal: true

require "rails_helper"

RSpec.describe UserNotBannedValidator do
  let(:sub) { create(:sub) }
  let(:ban) { create(:ban, sub: sub) }
  let(:model) { Sub::CreateBan.new(sub: sub) }
  subject { described_class.new(attributes: [:username]) }

  it "valid if user not banned in sub" do
    subject.validate_each(model, :username, "username")
    expect(model.errors[:username]).to be_empty
  end

  it "invalid if user banned in sub" do
    subject.validate_each(model, :username, ban.user.username)
    expect(model.errors[:username]).to include("пользователь забанен")
  end
end