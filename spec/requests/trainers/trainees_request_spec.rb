# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Trainers::Trainees', type: :request do
  subject do
    make_request
    response
  end

  include_context 'when a trainer'

  describe 'GET /index' do
    let(:make_request) { get trainers_trainees_path, headers: headers }
    let(:trainee) { create :trainee }
    let(:expected_trainee_json) { { 'id' => trainee.id, 'name' => trainee.name } }

    before { TrainerSelection.create!(trainee: trainee, trainer: trainer) }

    it 'returns a collection of trainers' do
      expect(subject).to be_successful
      expect(json).to eq([expected_trainee_json])
    end
  end
end
