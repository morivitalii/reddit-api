FactoryBot.define do
  factory :comment do
    user
    post
    community { post.community }
    text { "Text" }

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

    trait :removed do
      removed_at { Time.current }
      association :removed_by, factory: :user
    end

    trait :not_removed do
      removed_at { nil }
      removed_by { nil }
    end

    factory :comment_with_reports do
      transient do
        reports_count { 2 }
      end

      after(:create) do |comment, evaluator|
        create_list(:report, evaluator.reports_count, reportable: comment)
      end
    end

    factory :comment_with_bookmark do
      transient do
        bookmarked_by { create(:user) }
      end

      after(:create) do |comment, evaluator|
        create(:bookmark, bookmarkable: comment, user: evaluator.bookmarked_by)
      end
    end

    factory :not_moderated_comment, traits: [:not_moderated]
    factory :moderated_comment, traits: [:moderated]
    factory :not_removed_comment, traits: [:not_removed]
    factory :removed_comment, traits: [:removed]
    factory :not_approved_comment, traits: [:not_approved]
    factory :approved_comment, traits: [:approved]
    factory :not_edited_comment, traits: [:not_edited]
    factory :edited_comment, traits: [:edited]
  end
end
