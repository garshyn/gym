# frozen_string_literal: true

class AuthenticationsController < ApplicationController
  skip_before_action :authorize_request

  def create
    if user_record&.authenticate(params[:password])
      token = JsonWebToken.new(payload)
      render json: { token: token.encode, expired: I18n.l(token.expired) }
    else
      render json: { error: 'unauthorized' }, status: :unauthorized
    end
  end
end
