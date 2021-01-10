# frozen_string_literal: true

class Trainers::AuthenticationsController < AuthenticationsController
  private

  def user_record
    @user_record ||= Trainer.find_by(email: params[:email])
  end

  def payload
    { trainer_id: user_record.id }
  end
end
