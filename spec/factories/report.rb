FactoryBot.define do
  factory :report do
    reportable_post
    community { reportable.community }
    user
    text { "Text" }

    trait :reportable_post do
      association :reportable, factory: :post
    end

    trait :reportable_comment do
      association :reportable, factory: :comment
    end

    factory :post_report, traits: [:reportable_post]
    factory :comment_report, traits: [:reportable_comment]
  end
end
