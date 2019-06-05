# frozen_string_literal: true

FactoryBot.define do
  factory :bookmark do
    association :thing, factory: [:text_post]
    association :user, factory: :user
  end
end
