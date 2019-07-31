# frozen_string_literal: true

FactoryBot.define do
  factory :ban do
    global
    user
    association :banned_by, factory: :user
    reason { "Reason" }
    temporary

    trait :temporary do
      days { 1 }
      permanent { false }
    end

    trait :permanent do
      days { nil }
      permanent { true }
    end

    trait :global do
      sub { nil }
    end

    trait :sub do
      sub
    end

    factory :global_ban, traits: [:global]
    factory :sub_ban, traits: [:sub]
  end
end
