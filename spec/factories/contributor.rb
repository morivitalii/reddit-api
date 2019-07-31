# frozen_string_literal: true

FactoryBot.define do
  factory :contributor do
    global
    user
    association :approved_by, factory: :user

    trait :global do
      sub { nil }
    end

    trait :sub do
      sub
    end

    factory :global_contributor, traits: [:global]
    factory :sub_contributor, traits: [:sub]
  end
end
