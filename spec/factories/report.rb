# frozen_string_literal: true

FactoryBot.define do
  factory :report do
    association :reportable, factory: :post
    sub { reportable.sub }
    user
    text { "Text" }
  end
end
