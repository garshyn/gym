# frozen_string_literal: true

class Trainers::TraineeSerializer < ActiveModel::Serializer
  attributes :id, :name, :birthday
end
