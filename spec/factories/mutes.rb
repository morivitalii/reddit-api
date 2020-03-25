FactoryBot.define do
  factory :mute do
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

    factory :temporary_mute, traits: [:temporary]
    factory :permanent_mute, traits: [:permanent]
    factory :stale_mute, traits: [:stale]
  end
end
