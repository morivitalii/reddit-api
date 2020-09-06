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

    factory :stale_ban, traits: [:stale]
  end
end
