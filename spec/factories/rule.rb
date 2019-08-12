FactoryBot.define do
  factory :rule do
    sub
    sequence(:title) { |i| "Title #{i}" }
    sequence(:description) { |i| "Description #{i}" }
  end
end
