# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Trainee authentication', type: :request do
  describe 'POST /trainees/authentication' do
    subject do
      post trainees_authentication_path, params: params.to_json, headers: json_header
      response
    end

    let(:params) { { email: trainee.email, password: password } }
    let(:password) { trainee.password }
    let(:trainee) { create :trainee }
    let(:token) { JsonWebToken.new(trainee_id: trainee.id) }

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
