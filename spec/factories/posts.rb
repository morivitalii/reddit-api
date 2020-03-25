include ActionDispatch::TestProcess

FactoryBot.define do
  factory :post do
    association :created_by, factory: :user
    association :community
    title { "Title" }
    text

    trait :text do
      text { "Text" }
      file { nil }
    end

    trait :image do
      text { nil }
      file { fixture_file_upload(Rails.root.join("spec/fixtures/files/post_image.jpg")) }
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
      removed_by { nil }
      removed_at { nil }
    end

    trait :removed do
      association :removed_by, factory: :user
      removed_at { Time.current }
    end

    trait :explicit do
      explicit { true }
    end

    trait :not_explicit do
      explicit { false }
    end

    trait :spoiler do
      spoiler { true }
    end

    trait :not_spoiler do
      spoiler { false }
    end

    trait :ignore_reports do
      ignore_reports { true }
    end

    trait :not_ignore_reports do
      ignore_reports { false }
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

    factory :post_with_vote do
      transient do
        voted_by { create(:user) }
      end

      after(:create) do |post, evaluator|
        create(:vote, votable: post, user: evaluator.voted_by, vote_type: :up)

        post.update!({up_votes_count: 1})
      end
    end

    factory :post_with_up_vote do
      transient do
        voted_by { create(:user) }
      end

      after(:create) do |post, evaluator|
        create(:vote, votable: post, user: evaluator.voted_by, vote_type: :up)

        post.update!({up_votes_count: 1})
      end
    end

    factory :post_with_down_vote do
      transient do
        voted_by { create(:user) }
      end

      after(:create) do |post, evaluator|
        create(:vote, votable: post, user: evaluator.voted_by, vote_type: :down)

        post.update!({down_votes_count: 1})
      end
    end

    factory :post_with_topic do
      after(:create) do |post, _evaluator|
        post.create_topic!
      end
    end

    factory :explicit_post, traits: [:explicit]
    factory :not_explicit_post, traits: [:explicit]
    factory :spoiler_post, traits: [:spoiler]
    factory :not_spoiler_post, traits: [:spoiler]
    factory :ignore_reports_post, traits: [:ignore_reports]
    factory :not_ignore_reports_post, traits: [:not_ignore_reports]
    factory :not_moderated_post, traits: [:not_moderated]
    factory :moderated_post, traits: [:moderated]
    factory :not_removed_post, traits: [:not_removed]
    factory :removed_post, traits: [:removed]
    factory :not_approved_post, traits: [:not_approved]
    factory :approved_post, traits: [:approved]
    factory :not_edited_post, traits: [:not_edited]
    factory :edited_post, traits: [:edited]
    factory :text_post, traits: [:text]
    factory :image_post, traits: [:image]
  end
end
