class Trainees::TrainerSelectionsController < Trainees::BaseController
  def create
    TrainerSelection.create! trainee_id: current_user.id, trainer_id: params[:trainer_id]
  end

  def destroy
    TrainerSelection.find_by(trainee_id: current_user.id, trainer_id: params[:trainer_id])&.destroy
  end
end
