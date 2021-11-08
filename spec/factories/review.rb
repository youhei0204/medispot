# frozen_string_literal: true

FactoryBot.define do
  factory :review do
    title { 'test_title' }
    content { 'test_content' }
    rate { 3.0 }

    trait :user do
      association :user
    end
  end
end
