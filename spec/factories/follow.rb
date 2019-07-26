# frozen_string_literal: true

FactoryBot.define do
  factory :follow do
    sub
    user
  end
end
