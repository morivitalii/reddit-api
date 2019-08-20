FactoryBot.define do
  factory :post do
    user
    community
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
      removed_at { Time.current }
    end

    trait :not_moderated do
      approved_at { nil }
      removed_at { nil }
    end

    trait :not_approved do
      approved_by { nil }
      approved_at { nil }
    end

    trait :approved do
      association :approved_by, factory: :user
      approved_at { Time.current }
    end

    trait :removed do
      removed_at { Time.current }
      association :removed_by, factory: :user
    end

    factory :post_with_reports do
      transient do
        reports_count { 2 }
      end

      after(:create) do |post, evaluator|
        create_list(:report, evaluator.reports_count, reportable: post)
      end
    end

    factory :not_moderated_post, traits: [:not_moderated]
    factory :moderated_post, traits: [:moderated]
    factory :removed_post, traits: [:removed]
    factory :not_approved_post, traits: [:not_approved]
    factory :approved_post, traits: [:approved]
  end
end