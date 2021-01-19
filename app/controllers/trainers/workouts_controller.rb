# frozen_string_literal: true

class Trainers::WorkoutsController < Trainers::BaseController
  before_action :set_workout, only: %i[show update destroy]

  def index
    render json: current_user.workouts
  end

  # param months --> array of dates
  # returns a list of hashes {date: <a date>, total_seconds: <number of seconds of workout for that day>}
  def daily
    render json: Denormalizers::DailyResultsInProvidedMonths.call(current_user, params[:months].uniq)
  end

  def show
    render json: @workout
  end

  def create
    @workout = Workout.new(workout_params)
    @workout.creator_id = current_user.id
    @workout.total_duration = total_duration
    @workout.state ||= 'draft'

    if @workout.save
      render json: @workout, status: :created, location: [:trainers, @workout]
    else
      render json: @workout.errors, status: :unprocessable_entity
    end
  end

  def update
    @workout.assign_attributes(workout_params)
    @workout.total_duration = total_duration

    if @workout.save
      render json: @workout
    else
      render json: @workout.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @workout.destroy
  end

  private

  def set_workout
    @workout = current_user.workouts.find(params[:id])
  end

  def workout_params
    params.require(:workout).permit(:name, :state, exercise_ids: [])
  end

  def total_duration
    Exercise.where(id: workout_params[:exercise_ids]).sum(:duration)
  end
end
