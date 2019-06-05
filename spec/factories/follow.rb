# frozen_string_literal: true

FactoryBot.define do
  factory :follow do
    association :sub, factory: :sub
    association :user, factory: :user
  end
end
