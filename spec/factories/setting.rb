FactoryBot.define do
  factory :setting do
    sequence(:key) { |i| "key#{i}" }
    sequence(:value) { |i| "value#{i}" }
  end
end