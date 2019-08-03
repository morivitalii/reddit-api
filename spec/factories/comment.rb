FactoryBot.define do
  factory :comment do
    user
    post
    text { "Text" }

    trait :moderated do
      approved_at { Time.current }
      deleted_at { Time.current }
    end

    trait :not_moderated do
      approved_at { nil }
      deleted_at { nil }
    end

    factory :not_moderated_comment, traits: [:not_moderated]
    factory :moderated_comment, traits: [:moderated]
  end
end