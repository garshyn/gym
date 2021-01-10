# frozen_string_literal: true

class JsonWebToken
  SECRET_KEY = Rails.application.credentials.secret_key_base.to_s
  ALG = 'HS256'

  attr_reader :payload, :expired

  def initialize(payload, expired: 1.day.from_now)
    @payload = payload.with_indifferent_access
    @payload[:exp] ||= expired.to_i
    @expired = Time.zone.at(@payload[:exp])
  end

  def encode
    JWT.encode(payload, SECRET_KEY, ALG)
  end

  def self.decode(token)
    decoded = JWT.decode(token, SECRET_KEY, true, { algorithm: ALG })

    new decoded[0]
  end
end
