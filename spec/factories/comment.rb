FactoryBot.define do
  factory :comment do
    user
    post
    sub { post.sub }
    text { "Text" }

    trait :moderated do
      approved_at { Time.current }
      deleted_at { Time.current }
    end

    trait :not_moderated do
      approved_at { nil }
      deleted_at { nil }
    end
  end
end