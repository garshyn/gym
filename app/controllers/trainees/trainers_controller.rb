class Trainees::TrainersController < Trainees::BaseController
  def index
    render json: Trainer.all
  end
end
