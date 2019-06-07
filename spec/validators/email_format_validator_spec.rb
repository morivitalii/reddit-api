# frozen_string_literal: true

require "rails_helper"

describe EmailFormatValidator do
  let(:model) { User.new }
  subject { described_class.new(attributes: [:email]) }

  it "valid with valid email" do
    subject.validate_each(model, :email, "email@email.com")
    expect(model.errors[:email]).to be_empty
  end

  it "invalid with invalid email" do
    subject.validate_each(model, :email, "email")
    expect(model.errors[:email]).to include("имеет неверное значение")
  end
end