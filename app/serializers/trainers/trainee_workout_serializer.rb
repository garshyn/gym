# frozen_string_literal: true

class Trainers::TraineeWorkoutSerializer < ActiveModel::Serializer
  attributes :id, :name, :state, :medium_pulse
end
