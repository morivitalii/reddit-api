# frozen_string_literal: true

FactoryBot.define do
  factory :report do
    association :user, factory: :user
    text { "Text" }

    trait :post do
      association :thing, factory: :text_post
    end

    trait :comment do
      association :thing, factory: :root_comment
    end

    factory :post_report, traits: [:post]
    factory :comment_report, traits: [:comment]
  end
end
