# frozen_string_literal: true

FactoryBot.define do
  factory :vote do
    user
    association :votable, factory: :post
    up

    trait :up do
      vote_type { :up }
    end

    trait :meh do
      vote_type { :meh }
    end

    trait :down do
      vote_type { :down }
    end
  end
end
