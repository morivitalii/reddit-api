FactoryBot.define do
  factory :comment do
    post
    community { post.community }
    association :created_by, factory: :user

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

    trait :ignore_reports do
      ignore_reports { true }
    end

    trait :not_ignore_reports do
      ignore_reports { false }
    end

    trait :created_yesterday do
      created_at { 1.day.ago }
    end

    trait :created_today do
      created_at { Time.current }
    end

    trait :created_last_week do
      created_at { 1.week.ago }
    end

    trait :created_this_week do
      created_at { 6.days.ago }
    end

    trait :created_last_month do
      created_at { 1.month.ago }
    end

    trait :created_this_month do
      created_at { 27.days.ago }
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

    factory :comment_with_vote do
      transient do
        voted_by { create(:user) }
      end

      after(:create) do |comment, evaluator|
        create(:vote, votable: comment, user: evaluator.voted_by)

        comment.update!({up_votes_count: 1})
      end
    end

    factory :comment_with_up_vote do
      transient do
        voted_by { create(:user) }
      end

      after(:create) do |comment, evaluator|
        create(:vote, votable: comment, user: evaluator.voted_by, vote_type: :up)

        comment.update!({up_votes_count: 1})
      end
    end

    factory :comment_with_down_vote do
      transient do
        voted_by { create(:user) }
      end

      after(:create) do |comment, evaluator|
        create(:vote, votable: comment, user: evaluator.voted_by, vote_type: :down)

        comment.update!({down_votes_count: 1})
      end
    end

    factory :comment_with_parent_comment do
      after(:create) do |comment, evaluator|
        parent_comment = create(:comment)
        comment.comment = parent_comment
        comment.save!
      end
    end

    factory :ignore_reports_comment, traits: [:ignore_reports]
    factory :not_ignore_reports_comment, traits: [:not_ignore_reports]
    factory :not_moderated_comment, traits: [:not_moderated]
    factory :moderated_comment, traits: [:moderated]
    factory :not_removed_comment, traits: [:not_removed]
    factory :removed_comment, traits: [:removed]
    factory :not_approved_comment, traits: [:not_approved]
    factory :approved_comment, traits: [:approved]
    factory :not_edited_comment, traits: [:not_edited]
    factory :edited_comment, traits: [:edited]
    factory :created_yesterday_comment, traits: [:created_yesterday]
    factory :created_today_comment, traits: [:created_today]
    factory :created_last_week_comment, traits: [:created_last_week]
    factory :created_this_week_comment, traits: [:created_this_week]
    factory :created_last_month_comment, traits: [:created_last_month]
    factory :created_this_month_comment, traits: [:created_this_month]
  end
end
