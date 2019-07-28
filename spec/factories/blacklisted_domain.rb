FactoryBot.define do
  factory :blacklisted_domain do
    sub
    sequence(:domain) { |i| "example#{i}.com" }
  end
end