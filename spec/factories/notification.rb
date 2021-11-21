# frozen_string_literal: true

FactoryBot.define do
  factory :notification do
    sender_id { 1 }
    sender_name { 'test_sender' }
    request_type { 1 }
    subject { 'test_subject' }

    link_id { 1 }

    trait :user do
      association :user
    end
  end
end
