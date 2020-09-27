FactoryBot.define do
  factory :ban do
    association :source, factory: :community
    association :target, factory: :user
    association :created_by, factory: :user
    association :updated_by, factory: :user
    end_at { Time.current.tomorrow }

    trait :stale do
      end_at { Time.current.yesterday }
    end

    trait :community_source do
      association :source, factory: :community
    end

    trait :user_target do
      association :target, factory: :user
    end

    factory :stale_ban, traits: [:stale]
    factory :user_in_community_ban, traits: [:community_source, :user_target]
  end
end
