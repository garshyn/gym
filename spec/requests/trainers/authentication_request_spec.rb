# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Authentication', type: :request do
  describe 'POST /authentication' do
    subject do
      post trainers_authentication_path, params: params.to_json, headers: json_header
      response
    end

    let(:params) { { email: trainer.email, password: password } }
    let(:password) { trainer.password }
    let(:trainer) { create :trainer }
    let(:token) { JsonWebToken.new(trainer_id: trainer.id) }

    it 'returns jwt token' do
      freeze_time
      expect(subject).to be_successful
      expect(subject).to have_http_status(:success)
      expect(json).to eq(
        'token' => token.encode,
        'expired' => I18n.l(token.expired)
      )
      travel_back
    end

    context 'with wrong password' do
      let(:password) { 'wrong password' }

      it 'returns an error' do
        expect(subject).not_to be_successful
        expect(subject).to have_http_status(:unauthorized)
        expect(json).to eq(
          'error' => 'unauthorized'
        )
      end
    end
  end
end
