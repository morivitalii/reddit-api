# frozen_string_literal: true

FactoryBot.define do
  factory :moderator do
    sub
    user
    association :invited_by, factory: :user
  end
end
