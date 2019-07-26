FactoryBot.define do
  factory :rate_limit do
    association :user, factory: :user
    post

    trait :post do
      key { :post }
    end

    trait :comment do
      key { :comment }
    end
  end
end
