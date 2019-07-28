FactoryBot.define do
  factory :log do
    user
    sub
    association :loggable, factory: :post
    action { :create_page }
  end
end