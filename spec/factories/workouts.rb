# frozen_string_literal: true

FactoryBot.define do
  factory :workout do
    name { 'MyString' }
    association(:creator, factory: :trainer)
    total_duration { 0 }
    state { 'draft' }
  end
end
