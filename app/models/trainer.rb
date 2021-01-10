# frozen_string_literal: true

class Trainer < ApplicationRecord
  has_secure_password

  has_many :workouts, foreign_key: :creator_id, inverse_of: :creator, dependent: :destroy

  validates :first_name, presence: true
  validates :email, presence: true, uniqueness: { case_sensitive: false }, format: { with: URI::MailTo::EMAIL_REGEXP }
end
