require "rails_helper"

class UserNotBannedValidatorDummy
  include ActiveModel::Validations

  attr_accessor :username, :sub

  def initialize(sub)
    @sub = sub
  end

  validates :username, user_not_banned: true
end

RSpec.describe UserNotBannedValidator do
  subject { UserNotBannedValidatorDummy.new(sub) }

  describe ".validate_each" do
    let(:sub) { create(:sub) }
    let(:user) { create(:user) }

    context "invalid" do
      let!(:ban) { create(:ban, user: user, sub: sub) }

      it "adds error on username if user is banned" do
        subject.username = user.username
        subject.validate

        expect(subject).to have_error(:user_banned).on(:username)
      end
    end

    context "valid" do
      it "does not add error on username attribute if user is not banned" do
        subject.username = user.username

        expect(subject).to be_valid
      end
    end
  end
end