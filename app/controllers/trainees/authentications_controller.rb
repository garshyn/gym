# frozen_string_literal: true

class Trainees::AuthenticationsController < AuthenticationsController
  private

  def user_record
    @user_record ||= Trainee.find_by(email: params[:email])
  end

  def payload
    { trainee_id: user_record.id }
  end
end
