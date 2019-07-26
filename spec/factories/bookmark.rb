# frozen_string_literal: true

FactoryBot.define do
  factory :bookmark do
    user
    association :bookmarkable, factory: :post
  end
end
