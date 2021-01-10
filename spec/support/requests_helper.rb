# frozen_string_literal: true

module Requests
  module JsonHelpers
    def json
      JSON.parse(response.body)
    end

    def headers
      { 'CONTENT_TYPE' => 'application/json' }
    end
  end
end

RSpec.configure do |config|
  config.include Requests::JsonHelpers, type: :request
end
