# frozen_string_literal: true

require "rails_helper"

describe UserNotContributorValidator do
  let(:sub) { create(:sub) }
  let(:contributor) { create(:contributor, sub: sub) }
  let(:model) { CreateSubContributor.new(sub: sub) }
  subject { described_class.new(attributes: [:username]) }

  it "valid if user not contributor in sub" do
    subject.validate_each(model, :username, "username")
    expect(model.errors[:username]).to be_empty
  end

  it "invalid if user contributor in sub" do
    subject.validate_each(model, :username, contributor.user.username)
    expect(model.errors[:username]).to include("пользователь контрибутор")
  end
end