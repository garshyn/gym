# frozen_string_literal: true

class Trainee < ApplicationRecord
  has_secure_password

  has_many :trainer_selections, dependent: :destroy
  has_many :trainers, through: :trainer_selections

  validates :first_name, presence: true
  validates :email, presence: true, uniqueness: { case_sensitive: false }, format: { with: URI::MailTo::EMAIL_REGEXP }
end
