# frozen_string_literal: true

class Trainees::TraineeWorkoutSerializer < ActiveModel::Serializer
  attributes :id, :name, :state
end
