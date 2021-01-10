# frozen_string_literal: true

class WorkoutsController < ApplicationController
  before_action :set_workout, only: %i[show update destroy]

  def index
    @workouts = Workout.all

    render json: @workouts
  end

  def show
    render json: @workout
  end

  def create
    @workout = Workout.new(workout_params)
    @workout.creator_id = current_user.id
    @workout.total_duration = 0
    @workout.state ||= 'draft'

    if @workout.save
      render json: @workout, status: :created, location: @workout
    else
      render json: @workout.errors, status: :unprocessable_entity
    end
  end

  def update
    if @workout.update(workout_params)
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
    @workout = Workout.find(params[:id])
  end

  def workout_params
    params.require(:workout).permit(:name, :state)
  end
end
