# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    name { 'user' }
    email { 'user@test.com' }
    password { 'testuser' }
  end
end
