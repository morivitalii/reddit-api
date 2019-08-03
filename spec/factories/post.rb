FactoryBot.define do
  factory :post do
    user
    sub
    title { "Title" }
    text

    trait :text do
      text { "Text" }
      url { nil }
      media { nil }
    end

    trait :url do
      text { nil }
      url { "http://example.com/" }
      media { nil }
    end

    trait :media do
      text { nil }
      url { nil }
      # TODO
    end

    trait :moderated do
      approved_at { Time.current }
      deleted_at { Time.current }
    end

    trait :not_moderated do
      approved_at { nil }
      deleted_at { nil }
    end

    factory :not_moderated_post, traits: [:not_moderated]
    factory :moderated_post, traits: [:moderated]
  end
end