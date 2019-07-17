# frozen_string_literal: true

FactoryBot.define do
  factory :moderator do
    association :sub, factory: :sub
    association :user, factory: :user
    association :invited_by, factory: :user
  end
end
