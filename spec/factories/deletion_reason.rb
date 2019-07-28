# frozen_string_literal: true

FactoryBot.define do
  factory :deletion_reason do
    sub
    sequence(:title) { |i| "Title #{i}" }
    sequence(:description) { |i| "Description #{i}" }
  end
end
