# frozen_string_literal: true

class Trainees::TrainerSerializer < ActiveModel::Serializer
  attributes :id, :name, :selected

  def selected
    object.in? current_user.trainers
  end
end
