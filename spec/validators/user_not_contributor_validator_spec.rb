require "rails_helper"

class UserNotContributorValidatorDummy
  include ActiveModel::Validations

  attr_accessor :username, :sub

  def initialize(sub)
    @sub = sub
  end

  validates :username, user_not_contributor: true
end

RSpec.describe UserNotContributorValidator do
  subject { UserNotContributorValidatorDummy.new(sub) }

  describe ".validate_each" do
    let(:sub) { create(:sub) }
    let(:user) { create(:user) }

    context "invalid" do
      let!(:contributor) { create(:contributor, user: user, sub: sub) }

      it "adds error on username if user is contributor" do
        subject.username = user.username
        subject.validate

        expect(subject).to have_error(:user_contributor).on(:username)
      end
    end

    context "valid" do
      it "does not add error on username attribute if user is not contributor" do
        subject.username = user.username

        expect(subject).to be_valid
      end
    end
  end
end