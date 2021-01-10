# frozen_string_literal: true

FactoryBot.define do
  factory :workout do
    name { 'MyString' }
    creator { nil }
    total_duration { 1 }
    state { 'MyString' }
  end
end
