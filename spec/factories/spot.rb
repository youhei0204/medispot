# frozen_string_literal: true

FactoryBot.define do
  factory :spot do
    name { 'test_spot' }
    address { 'test_address' }
    lat { 123 }
    lng { 123 }
    sequence(:place_id) { |n| "place_id_#{n}" }
  end
end
