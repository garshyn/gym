# frozen_string_literal: true

class Exercise < ApplicationRecord
  has_and_belongs_to_many :workouts
  validates :name, presence: true
end
