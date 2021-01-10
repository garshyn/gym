# frozen_string_literal: true

class Trainees::TrainersController < Trainees::BaseController
  def index
    render json: trainers
  end

  private

  def trainers
    params[:expertise].present? ? Trainer.tagged_with(params[:expertise]) : Trainer.all
  end
end
