# frozen_string_literal: true

FactoryBot.define do
  factory :ban do
    association :user, factory: :user
    association :banned_by, factory: :user

    trait :local do
      association :sub, factory: :sub
    end

    trait :temporary do
      days { 7 }
    end

    trait :permanent do
      days { nil }
      permanent { true }
    end

    trait :with_reason do
      reason { "Reason" }
    end

    factory :temporary_global_ban, traits: [:temporary]
    factory :permanent_global_ban, traits: [:permanent]
    factory :temporary_sub_ban, traits: [:local, :temporary]
    factory :permanent_sub_ban, traits: [:local, :permanent]
  end
end
