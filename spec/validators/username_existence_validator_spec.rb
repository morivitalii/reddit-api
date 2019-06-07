# frozen_string_literal: true

require "rails_helper"

RSpec.describe UsernameExistenceValidator do
  let(:user) { create(:user) }
  let(:model) { User.new }
  subject { described_class.new(attributes: [:username]) }

  it "valid if user with username exists" do
    subject.validate_each(model, :username, user.username)
    expect(model.errors[:username]).to be_empty
  end

  it "invalid if user with username does not exists" do
    subject.validate_each(model, :username, "username")
    expect(model.errors[:username]).to include("пользователь с таким именем не зарегистрирован")
  end
end