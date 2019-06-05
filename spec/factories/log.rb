FactoryBot.define do
  factory :log do
    association :user, factory: :user

    trait :local do
      association :sub, factory: :sub
    end

    trait :loggable_user do
      association :loggable, factory: :user
    end

    trait :loggable_post do
      association :loggable, factory: :text_post
    end

    factory :global_log
    factory :sub_log, traits: [:local]
  end
end