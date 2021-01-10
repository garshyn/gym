# frozen_string_literal: true

FactoryBot.define do
  factory :trainee do
    first_name { 'MyString' }
    last_name { 'MyString' }
    sequence(:email) { |n| "trainee_#{n}@example.com" }
    password { 'password' }
  end
end
