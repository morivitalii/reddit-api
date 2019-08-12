# frozen_string_literal: true

FactoryBot.define do
  factory :contributor do
    sub
    user
    association :approved_by, factory: :user
  end
end
