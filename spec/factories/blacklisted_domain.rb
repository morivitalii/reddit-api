FactoryBot.define do
  factory :blacklisted_domain do
    sequence(:domain) { |i| "example#{i}.com" }

    trait :local do
      association :sub, factory: :sub
    end

    factory :global_blacklisted_domain
    factory :sub_blacklisted_domain, traits: [:local]
  end
end