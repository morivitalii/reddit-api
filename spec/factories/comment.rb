FactoryBot.define do
  factory :comment do
    user
    post
    text { "Text" }
  end
end