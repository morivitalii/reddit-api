# frozen_string_literal: true

FactoryBot.define do
  factory :thing do
    association :sub, factory: :sub
    association :user, factory: :user

    trait :post do
      title { "Post" }
      thing_type { :post }
    end

    trait :comment do
      association :post, [:text_post], factory: :thing
      thing_type { :comment }
      content_type { :text }
      text { "Comment" }
    end

    trait :text_post do
      post
      content_type { :text }
      text { "Post" }
    end

    trait :link_post do
      post
      content_type { :link }
      url { "http://example.com/" }
    end

    trait :media_post do
      post
      content_type { :media }
      # TODO each type of file
    end

    trait :root_comment do
      comment
    end

    trait :nested_comment do
      comment
      association :comment, [:root_comment], factory: :thing
    end

    trait :deleted do
      association :deleted_by, factory: :user
      deleted_at { Time.current }
      deletion_reason { "Deletion reason" }
    end

    trait :approved do
      association :approved_by, factory: :user
      approved_at { Time.current }
    end

    trait :explicit do
      explicit { true }
    end

    trait :spoiler do
      spoiler { true }
    end

    trait :with_tag do
      tag { "Tag" }
    end

    trait :edited do
      edited_at { Time.current }
    end

    factory :text_post, traits: [:text_post]
    factory :link_post, traits: [:link_post]
    factory :media_post, traits: [:media_post]
    factory :root_comment, traits: [:root_comment]
    factory :nested_comment, traits: [:nested_comment]
  end
end
