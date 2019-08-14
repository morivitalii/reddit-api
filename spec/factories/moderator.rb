# frozen_string_literal: true

FactoryBot.define do
  factory :moderator do
    community
    user
  end
end
