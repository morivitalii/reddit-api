# frozen_string_literal: true

FactoryBot.define do
  factory :sub do
    user
    sequence(:url) { |i| "sub#{i}" }
    sequence(:title) { |i| "Sub #{i}" }
    sequence(:description) { |i| "Description #{i}" }
  end
end
