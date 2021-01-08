# frozen_string_literal: true

class Trainer < ApplicationRecord
  validates :first_name, presence: true
end
