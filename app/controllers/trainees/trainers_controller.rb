# frozen_string_literal: true

class Trainees::TrainersController < Trainees::BaseController
  def index
    render json: Trainer.all
  end
end
