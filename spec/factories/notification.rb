FactoryBot.define do
  factory :notification do
    user
    association :notifiable, factory: :post
  end
end