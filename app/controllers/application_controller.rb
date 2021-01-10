# frozen_string_literal: true

class ApplicationController < ActionController::API
  before_action :authorize_request

  attr_reader :current_user

  protected

  def authorize_request
    header = request.headers['Authorization']
    header = header.split.last if header

    begin
      token = JsonWebToken.decode(header)

      @current_user = Trainer.find(token.payload[:trainer_id])
    rescue ActiveRecord::RecordNotFound, JWT::DecodeError => e
      render json: { errors: e.message }, status: :unauthorized
    end
  end
end
