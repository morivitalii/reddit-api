FactoryBot.define do
  factory :post do
    user
    sub
    title { "Title" }
    text

    trait :text do
      text { "Text" }
      url { nil }
      media { nil }
    end

    trait :url do
      text { nil }
      url { "http://example.com/" }
      media { nil }
    end

    trait :media do
      text { nil }
      url { nil }
      # TODO
    end
  end
end