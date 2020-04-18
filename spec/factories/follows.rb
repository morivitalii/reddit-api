FactoryBot.define do
  factory :follow do
    user

    trait :community do
      association :followable, factory: :community
    end

    factory :community_follow, traits: [:community]
  end
end
