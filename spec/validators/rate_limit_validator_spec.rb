# frozen_string_literal: true

require "rails_helper"

describe RateLimitValidator do
  let(:user) {  }
  let(:sub) { create(:sub) }
  let(:model) { CreateTextPost.new(current_user: user, sub: sub) }
  subject { described_class.new(attributes: [:title], key: ->(r) { r.thing_type }, sub: ->(r) { r.sub }) }
  before { Current.user = create(:user) }

  context "valid if under rate limits" do
    let(:limit) { create(:limit, user: user, key: :post, hits: 49) }
    before { limit }

    it do
      subject.validate_each(model, :title, nil)
      expect(model.errors[:title]).to be_empty
    end
  end

  context "invalid if beyond rate limits" do
    let(:limit) { create(:limit, user: user, key: :post, hits: 50) }
    before { limit }

    it do
      subject.validate_each(model, :title, nil)
      expect(model.errors[:title]).to include("вы выполняете это действие слишком часто. подождите немного и попробуйте еще раз")
    end
  end

end