# frozen_string_literal: true

require "rails_helper"

RSpec.describe UserNotStaffValidator do
  let(:staff) { create(:staff) }
  let(:model) { User.new }
  subject { described_class.new(attributes: [:username]) }

  context "valid if user not staff" do
    it do
      subject.validate_each(model, :username, "username")
      expect(model.errors[:username]).to be_empty
    end
  end

  context "invalid if user staff" do
    before { staff }

    it do
      subject.validate_each(model, :username, staff.user.username)
      expect(model.errors[:username]).to include("пользователь администратор")
    end
  end
end