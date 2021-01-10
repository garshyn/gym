# frozen_string_literal: true

class TraineeWorkout < ApplicationRecord
  belongs_to :trainer
  belongs_to :trainee
  belongs_to :workout
  belongs_to :current_exercise, optional: true, class_name: 'Exercise'

  enum state: { assigned: 'assigned', started: 'started', canceled: 'canceled', finished: 'finished' }
end
