# frozen_string_literal: true

class Trainees::WorkoutsController < Trainees::BaseController
  def index
    render json: TraineeWorkout.where(trainee: current_user)
  end
end
