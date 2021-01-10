require 'rails_helper'

RSpec.describe 'Trainees::Trainers', type: :request do
  subject do
    make_request
    response
  end

  include_context 'when a trainee'

  describe 'GET /index' do
    let(:make_request) { get trainees_trainers_path, headers: headers }
    let!(:trainer) { create :trainer }
    let(:expected_trainer_json) { { 'id' => trainer.id, 'name' => trainer.name, 'selected' => selected } }
    let(:selected) { false }

    it 'returns a collection of trainers' do
      expect(subject).to be_successful
      expect(json).to eq([expected_trainer_json])
    end

    context 'when trainer is selected' do
      let(:selected) { true }

      before { TrainerSelection.create!(trainee: trainee, trainer: trainer) }

      it 'returns a collection of trainers' do
        expect(subject).to be_successful
        expect(json).to eq([expected_trainer_json])
      end
    end
  end
end
