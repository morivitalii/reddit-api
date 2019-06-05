# frozen_string_literal: true

describe UsernameFormatValidator do
  let(:model) { User.new }
  subject { described_class.new(attributes: [:username]) }

  it "valid with valid username" do
    subject.validate_each(model, :username, "username")
    expect(model.errors[:username]).to be_empty
  end

  it "invalid with invalid username" do
    subject.validate_each(model, :username, "u")
    expect(model.errors[:username]).to include("от 2 до 16 символов. только английские буквы, цифры и символ подчёркивания")
  end
end