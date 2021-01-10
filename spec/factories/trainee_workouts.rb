# frozen_string_literal: true

FactoryBot.define do
  factory :trainee_workout do
    association :trainer
    association :trainee
    association :workout
    state { 'assigned' }
    association :current_exercise, factory: :exercise
    medium_pulse { 1 }
  end
end
