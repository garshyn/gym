# frozen_string_literal: true

class TraineeWorkout < ApplicationRecord
  belongs_to :trainer
  belongs_to :trainee
  belongs_to :workout

  enum state: { assigned: 'assigned', started: 'started', canceled: 'canceled', finished: 'finished' }
end
