FactoryBot.define do
  factory :rate_limit do
    association :user, factory: :user
    action { "action" }

    trait :stale do
      created_at { 1.week.ago }
    end

    factory :stale_rate_limit, traits: [:stale]
  end
end
