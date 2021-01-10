class Trainers::TraineesController < Trainers::BaseController
  def index
    render json: Trainee.joins(:trainer_selections).where(trainer_selections: { trainer: current_user })
  end
end
