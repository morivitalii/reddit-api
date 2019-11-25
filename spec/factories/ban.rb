FactoryBot.define do
  factory :ban do
    community
    user
    temporary

    trait :temporary do
      days { 1 }
      permanent { false }
    end

    trait :permanent do
      days { nil }
      permanent { true }
    end

    trait :stale do
      days { 1 }
      permanent { false }
      created_at { 1.week.ago }
    end

    factory :temporary_ban, traits: [:temporary]
    factory :permanent_ban, traits: [:permanent]
    factory :stale_ban, traits: [:stale]
  end
end
