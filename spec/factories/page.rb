FactoryBot.define do
  factory :page do
    sub
    association :edited_by, factory: :user

    sequence(:title) { |i| "Title #{i}" }
    sequence(:text) { |i| "Text #{i}" }
  end
end
