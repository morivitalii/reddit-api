FactoryBot.define do
  factory :page do
    association :edited_by, factory: :user

    sequence(:title) { |i| "Title #{i}" }
    sequence(:text) { |i| "Text #{i}" }

    trait :local do
      association :sub, factory: :sub
    end

    factory :global_page
    factory :sub_page, traits: [:local]
  end
end
