FactoryBot.define do
  factory :rule do
    sequence(:title) { |i| "Title #{i}" }
    sequence(:description) { |i| "Description #{i}" }

    trait :local do
      association :sub, factory: :sub
    end

    factory :global_rule
    factory :sub_rule, traits: [:local]
  end
end
