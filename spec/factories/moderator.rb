# frozen_string_literal: true

FactoryBot.define do
  factory :moderator do
    association :sub, factory: :sub
    association :user, factory: :user
    association :invited_by, factory: :user

    trait :plain do
      master { false }
    end

    trait :master do
      master { true }
    end

    factory :plain_moderator, traits: [:plain]
    factory :master_moderator, traits: [:master]
  end
end
