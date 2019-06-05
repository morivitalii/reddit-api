FactoryBot.define do
  factory :notification do
    association :user, factory: :user

    trait :root_comment do
      association :thing, factory: :root_comment
    end

    trait :nested_comment do
      association :thing, factory: :nested_comment
    end

    factory :root_comment_notification, traits: [:root_comment]
    factory :nested_comment_notification, traits: [:nested_comment]
  end
end