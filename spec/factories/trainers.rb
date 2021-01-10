# frozen_string_literal: true

FactoryBot.define do
  factory :trainer do
    first_name { 'MyString' }
    last_name { 'MyString' }
    sequence(:email) { |n| "trainer_#{n}@example.com" }
    password { 'password' }
  end
end
