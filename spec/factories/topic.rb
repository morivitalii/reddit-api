# frozen_string_literal: true

FactoryBot.define do
  factory :topic do
    association :post, factory: :text_post
  end
end
