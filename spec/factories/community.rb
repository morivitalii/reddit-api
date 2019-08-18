# frozen_string_literal: true

FactoryBot.define do
  factory :community do
    sequence(:url) { |i| "community#{i}" }
    sequence(:title) { |i| "Community #{i}" }
    sequence(:description) { |i| "Description #{i}" }

    trait :default do
      url { "all" }
    end

    factory :default_community, traits: [:default]

    factory :community_with_moderators do
      transient do
        moderators_count { 2 }
        moderator_user { create(:user) }
      end

      after(:create) do |community, evaluator|
        create_list(:moderator, evaluator.moderators_count, community: community, user: evaluator.moderator_user)
      end
    end

    factory :community_with_followers do
      transient do
        followers_count { 2 }
        follower_user { create(:user) }
      end

      after(:create) do |community, evaluator|
        create_list(:follow, evaluator.followers_count, community: community, user: evaluator.follower_user)
      end
    end

    factory :community_with_user_moderator do
      transient do
        user { create(:user) }
      end

      after(:create) do |community, evaluator|
        create(:moderator, community: community, user: evaluator.user)
      end
    end

    factory :community_with_user_follower do
      transient do
        user { create(:user) }
      end

      after(:create) do |community, evaluator|
        create(:follow, community: community, user: evaluator.user)
      end
    end

    factory :community_with_banned_user do
      transient do
        user { create(:user) }
      end

      after(:create) do |community, evaluator|
        create(:ban, community: community, user: evaluator.user)
      end
    end
  end
end
