# frozen_string_literal: true

FactoryBot.define do
  factory :contributor do
    association :sub, factory: :sub
    association :user, factory: :user
    association :approved_by, factory: :user
  end
end
