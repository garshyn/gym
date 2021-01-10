# frozen_string_literal: true

class ApplicationController < ActionController::API
  before_action :authorize_request

  attr_reader :current_user

  protected

  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  def authorize_request
    header = request.headers['Authorization']
    header = header.split.last if header

    begin
      token = JsonWebToken.decode(header)

      @current_user = Trainer.find(token.payload[:trainer_id])
    rescue JWT::DecodeError => e
      render json: { error: e.message }, status: :unauthorized
    end
  end

  def record_not_found
    render json: { error: 'Record not found' }, status: :unauthorized
  end
end
