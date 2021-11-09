# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    sequence(:name) { |n| "name_#{n}" }
    sequence(:email) { |n| "email_#{n}@test.com" }
    password { 'testuser' }
    introduction { 'I was created just for testing' }
  end
end
