FactoryBot.define do
  factory :rate_limit do
    association :user, factory: :user
    post_key

    trait :post_key do
      key { :post }
    end

    trait :comment_key do
      key { :comment }
    end

    trait :stale do
      created_at { 1.week.ago }
    end

    factory :post_rate_limit, traits: [:post_key]
    factory :comment_rate_limit, traits: [:comment_key]
    factory :stale_rate_limit, traits: [:stale]
  end
end
