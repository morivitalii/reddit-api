FactoryBot.define do
  factory :tag do
    community
    sequence(:text) { |i| "Text #{i}" }
  end
end
