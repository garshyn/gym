# frozen_string_literal: true

class AuthenticationsController < ApplicationController
  skip_before_action :authorize_request

  def create
    @trainer = Trainer.find_by(email: params[:email])
    if @trainer&.authenticate(params[:password])
      token = JsonWebToken.new(trainer_id: @trainer.id)
      render json: { token: token.encode, expired: I18n.l(token.expired) }
    else
      render json: { error: 'unauthorized' }, status: :unauthorized
    end
  end
end
