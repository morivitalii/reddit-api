FactoryBot.define do
  factory :page do
    global
    association :edited_by, factory: :user

    sequence(:title) { |i| "Title #{i}" }
    sequence(:text) { |i| "Text #{i}" }

    trait :global do
      sub { nil }
    end

    trait :sub do
      sub
    end

    factory :global_page, traits: [:global]
    factory :sub_page, traits: [:sub]
  end
end
