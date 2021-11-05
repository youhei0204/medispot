# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    name { 'testuser1' }
    email { 'user@test.com' }
    password { 'testuser' }
    introduction { 'I was created just for testing' }
  end
end
