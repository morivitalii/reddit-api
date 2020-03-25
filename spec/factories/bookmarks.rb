FactoryBot.define do
  factory :bookmark do
    user
    bookmarkable_post

    trait :bookmarkable_post do
      association :bookmarkable, factory: :post
    end

    trait :bookmarkable_comment do
      association :bookmarkable, factory: :comment
    end

    factory :post_bookmark, traits: [:bookmarkable_post]
    factory :comment_bookmark, traits: [:bookmarkable_comment]
  end
end
