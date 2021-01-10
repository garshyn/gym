# frozen_string_literal: true

class Trainee < ApplicationRecord
  has_secure_password

  has_many :trainer_selections, dependent: :destroy
  has_many :trainers, through: :trainer_selections
  has_many :trainee_workouts, dependent: :destroy

  validates :first_name, presence: true
  validates :email, presence: true, uniqueness: { case_sensitive: false }, format: { with: URI::MailTo::EMAIL_REGEXP }

  def name
    [first_name, last_name].compact.join(' ')
  end
end
