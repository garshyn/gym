# frozen_string_literal: true

FactoryBot.define do
  factory :workout do
    sequence(:name) { |n| "Workout #{n}" }
    association(:creator, factory: :trainer)
    total_duration { 0 }
    state { 'draft' }
  end
end
