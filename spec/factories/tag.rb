FactoryBot.define do
  factory :tag do
    association :sub, factory: :sub
    sequence(:title) { |i| "Title #{i}" }
  end
end
