# frozen_string_literal: true

FactoryBot.define do
  factory :deletion_reason do
    sequence(:title) { |i| "Title #{i}" }
    sequence(:description) { |i| "Description #{i}" }

    trait :local do
      association :sub, factory: :sub
    end

    factory :global_deletion_reason
    factory :sub_deletion_reason, traits: [:local]
  end
end
