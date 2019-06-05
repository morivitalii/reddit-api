# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    sequence(:username) { |i| "user#{i}" }
    sequence(:email) { |i| "user#{i}@mail.com" }
    password { "password" }
  end
end
