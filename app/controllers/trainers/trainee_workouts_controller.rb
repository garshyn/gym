# frozen_string_literal: true

class Trainers::TraineeWorkoutsController < Trainers::BaseController
  def index
    trainee = Trainee.find(params[:trainee_id])
    render json: trainee.trainee_workouts
  end

  def create
    render json: TraineeWorkout.create!(
      trainee_workout_params.merge(
        trainer_id: current_user.id,
        state: 'assigned'
      )
    )
  end

  def destroy
    TraineeWorkout.find(params[:id]).destroy
  end

  private

  def trainee_workout_params
    params.require(:trainee_workout).permit(:trainee_id, :workout_id)
  end
end
