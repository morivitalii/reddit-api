FactoryBot.define do
  factory :post do
    user
    sub
    topic
    title { "Title" }

    trait :text do
      text { "Text" }
    end

    trait :url do
      url { "http://example.com/" }
    end

    trait :media do
      # TODO
    end
  end
end