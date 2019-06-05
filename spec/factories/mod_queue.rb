FactoryBot.define do
  factory :mod_queue do
    association :sub, factory: :sub

    trait :post do
      association :thing, factory: :text_post
      thing_type { :post }
    end

    trait :comment do
      association :thing, factory: :root_comment
      thing_type { :comment }
    end

    trait :not_approved do
      queue_type { :not_approved }
    end

    trait :reported do
      queue_type { :reported }
    end

    factory :not_approved_post_mod_queue, traits: [:post, :not_approved]
    factory :not_approved_comment_mod_queue, traits: [:comment, :not_approved]
    factory :reported_post_mod_queue, traits: [:post, :reported]
    factory :reported_comment_mod_queue, traits: [:comment, :reported]
  end
end