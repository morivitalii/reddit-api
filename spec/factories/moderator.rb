# frozen_string_literal: true

FactoryBot.define do
  factory :moderator do
    global
    user
    association :invited_by, factory: :user

    trait :global do
      sub { nil }
    end

    trait :sub do
      sub
    end

    factory :global_moderator, traits: [:global]
    factory :sub_moderator, traits: [:sub]
  end
end
