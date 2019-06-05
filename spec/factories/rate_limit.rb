FactoryBot.define do
  factory :rate_limit do
    association :user, factory: :user

    trait :post do
      key { :post }
    end

    trait :comment do
      key { :comment }
    end

    factory :post_rate_limit, traits: [:post]
    factory :comment_rate_limit, traits: [:comment]
  end
end
