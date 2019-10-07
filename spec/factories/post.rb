include ActionDispatch::TestProcess

FactoryBot.define do
  factory :post do
    user
    community
    title { "Title" }
    text

    trait :text do
      text { "Text" }
      url { nil }
      image { nil }
    end

    trait :link do
      text { nil }
      url { "http://example.com/" }
      image { nil }
    end

    trait :image do
      text { nil }
      url { nil }
      image { fixture_file_upload(Rails.root.join("spec/fixtures/files/post_image.jpg")) }
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

    trait :not_edited do
      edited_by { nil }
      edited_at { nil }
    end

    trait :edited do
      association :edited_by, factory: :user
      edited_at { Time.current }
    end

    trait :not_removed do
      removed_at { nil }
      removed_by { nil }
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

    factory :post_with_bookmark do
      transient do
        bookmarked_by { create(:user) }
      end

      after(:create) do |post, evaluator|
        create(:bookmark, bookmarkable: post, user: evaluator.bookmarked_by)
      end
    end

    factory :not_moderated_post, traits: [:not_moderated]
    factory :moderated_post, traits: [:moderated]
    factory :not_removed_post, traits: [:not_removed]
    factory :removed_post, traits: [:removed]
    factory :not_approved_post, traits: [:not_approved]
    factory :approved_post, traits: [:approved]
    factory :not_edited_post, traits: [:not_edited]
    factory :edited_post, traits: [:edited]
    factory :text_post, traits: [:text]
    factory :link_post, traits: [:link]
    factory :image_post, traits: [:image]
  end
end
