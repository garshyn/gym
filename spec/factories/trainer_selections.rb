# frozen_string_literal: true

FactoryBot.define do
  factory :trainer_selection do
    association :trainee
    association :trainer
  end
end
