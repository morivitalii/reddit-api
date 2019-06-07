# frozen_string_literal: true

require "rails_helper"

RSpec.describe EmailUniquenessValidator do
  let(:user) { create(:user) }
  let(:model) { User.new }
  subject { described_class.new(attributes: [:email]) }

  it "valid if user with given email does not exist" do
    subject.validate_each(model, :email, "email@email.com")
    expect(model.errors[:email]).to be_empty
  end

  it "invalid if user with given email exists" do
    subject.validate_each(model, :email, user.email)
    expect(model.errors[:email]).to include("email занят")
  end
end