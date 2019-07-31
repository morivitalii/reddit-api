# frozen_string_literal: true

FactoryBot.define do
  factory :deletion_reason do
    global
    sequence(:title) { |i| "Title #{i}" }
    sequence(:description) { |i| "Description #{i}" }

    trait :global do
      sub { nil }
    end

    trait :sub do
      sub
    end

    factory :global_deletion_reason, traits: [:global]
    factory :sub_deletion_reason, traits: [:sub]
  end
end
