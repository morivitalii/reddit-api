# frozen_string_literal: true

FactoryBot.define do
  factory :community do
    sequence(:url) { |i| "community#{i}" }
    sequence(:title) { |i| "Community #{i}" }
    sequence(:description) { |i| "Description #{i}" }
  end
end
