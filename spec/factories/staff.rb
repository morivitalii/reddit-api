# frozen_string_literal: true

FactoryBot.define do
  factory :staff do
    association :user, factory: :user
  end
end
