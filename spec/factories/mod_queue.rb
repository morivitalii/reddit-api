FactoryBot.define do
  factory :mod_queue do
    trait :post do
      association :thing, factory: :text_post
    end

    trait :comment do
      association :thing, factory: :root_comment
    end
  end
end