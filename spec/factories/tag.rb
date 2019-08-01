FactoryBot.define do
  factory :tag do
    global
    sequence(:title) { |i| "Title #{i}" }

    trait :global do
      sub { nil }
    end

    trait :sub do
      sub
    end

    factory :global_tag, traits: [:global]
    factory :sub_tag, traits: [:sub]
  end
end
