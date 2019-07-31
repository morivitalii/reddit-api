FactoryBot.define do
  factory :rule do
    global
    sequence(:title) { |i| "Title #{i}" }
    sequence(:description) { |i| "Description #{i}" }

    trait :global do
      sub { nil }
    end

    trait :sub do
      sub
    end

    factory :global_rule, traits: [:global]
    factory :sub_rule, traits: [:sub]
  end
end
