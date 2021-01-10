# frozen_string_literal: true

class Trainees::AuthenticationsController < ApplicationController
  skip_before_action :authorize_request

  def create
    @trainee = Trainee.find_by(email: params[:email])
    if @trainee&.authenticate(params[:password])
      token = JsonWebToken.new(trainee_id: @trainee.id)
      render json: { token: token.encode, expired: I18n.l(token.expired) }
    else
      render json: { error: 'unauthorized' }, status: :unauthorized
    end
  end
end
