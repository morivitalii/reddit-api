# frozen_string_literal: true

describe UsernameUniquenessValidator do
  let(:user) { create(:user) }
  let(:model) { User.new }
  subject { described_class.new(attributes: [:username]) }

  it "valid if user with username does not exist" do
    subject.validate_each(model, :username, "username")
    expect(model.errors[:username]).to be_empty
  end

  it "invalid if user with username exists" do
    subject.validate_each(model, :username, user.username)
    expect(model.errors[:username]).to include("имя пользователя занято")
  end
end