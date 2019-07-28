# frozen_string_literal: true

FactoryBot.define do
  factory :report do
    sub
    user
    association :reportable, factory: :post
    text { "Text" }
  end
end
