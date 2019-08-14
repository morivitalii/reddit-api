# frozen_string_literal: true

FactoryBot.define do
  factory :follow do
    community
    user
  end
end
