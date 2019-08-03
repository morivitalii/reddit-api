# frozen_string_literal: true

FactoryBot.define do
  factory :report do
    reportable_post
    sub { reportable.sub }
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
