FactoryBot.define do
  factory :blacklisted_domain do
    global
    sequence(:domain) { |i| "example#{i}.com" }

    trait :global do
      sub { nil }
    end

    trait :sub do
      sub
    end

    factory :global_blacklisted_domain, traits: [:global]
    factory :sub_blacklisted_domain, traits: [:sub]
  end
end