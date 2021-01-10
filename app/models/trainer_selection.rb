# frozen_string_literal: true

class TrainerSelection < ApplicationRecord
  belongs_to :trainee
  belongs_to :trainer
end
