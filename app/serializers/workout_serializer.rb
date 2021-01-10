# frozen_string_literal: true

class WorkoutSerializer < ActiveModel::Serializer
  attributes :id, :name, :total_duration
end
