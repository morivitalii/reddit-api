# frozen_string_literal: true

FactoryBot.define do
  factory :vote do
    user
    votable_post
    up

    trait :up do
      vote_type { :up }
    end

    trait :down do
      vote_type { :down }
    end

    trait :meh do
      vote_type { :meh }
    end

    trait :votable_post do
      association :votable, factory: :post
    end

    trait :votable_comment do
      association :votable, factory: :comment
    end

    factory :post_vote, traits: [:votable_post]
    factory :comment_vote, traits: [:votable_comment]
    factory :up_vote, traits: [:up]
    factory :down_vote, traits: [:down]
    factory :meh_vote, traits: [:meh]
  end
end
