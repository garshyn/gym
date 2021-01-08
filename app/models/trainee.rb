# frozen_string_literal: true

class Trainee < ApplicationRecord
  validates :first_name, presence: true
  validates :email, presence: true, uniqueness: { case_sensitive: false }, format: { with: URI::MailTo::EMAIL_REGEXP }
end
