# frozen_string_literal: true

FactoryBot.define do
  factory :vote do
    association :user, factory: :user

    trait :post do
      association :thing, factory: :text_post
    end

    trait :comment do
      association :thing, factory: :root_comment
    end

    trait :up do
      vote_type { :up }
    end

    trait :meh do
      vote_type { :meh }
    end

    trait :down do
      vote_type { :down }
    end

    factory :post_up_vote, traits: [:post, :up]
    factory :post_meh_vote, traits: [:post, :meh]
    factory :post_down_vote, traits: [:post, :down]
    factory :comment_up_vote, traits: [:comment, :up]
    factory :comment_meh_vote, traits: [:comment, :meh]
    factory :comment_down_vote, traits: [:comment, :down]
  end
end
