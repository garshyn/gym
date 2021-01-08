# frozen_string_literal: true

FactoryBot.define do
  factory :trainee do
    first_name { 'MyString' }
    last_name { 'MyString' }
    email { 'email@example.com' }
  end
end
