FactoryBot.define do
  factory :tag do
    sub
    sequence(:title) { |i| "Title #{i}" }
  end
end
