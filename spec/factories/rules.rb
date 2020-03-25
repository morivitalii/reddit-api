FactoryBot.define do
  factory :rule do
    community
    sequence(:title) { |i| "Title #{i}" }
    sequence(:description) { |i| "Description #{i}" }
  end
end
