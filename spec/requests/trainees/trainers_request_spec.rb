# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Trainees::Trainers', type: :request do
  subject do
    make_request
    response
  end

  include_context 'when a trainee'

  describe 'GET /index' do
    let(:make_request) { get trainees_trainers_path, headers: headers }
    let!(:trainer) { create :trainer, expertise_list: ['yoga'] }
    let(:expected_trainer_json) do
      {
        'id' => trainer.id,
        'name' => trainer.name,
        'selected' => selected,
        'expertise' => ['yoga']
      }
    end
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

    context 'with filter by tag' do
      let(:make_request) { get trainees_trainers_path(expertise: 'yoga'), headers: headers }

      context 'when matching' do
        let!(:trainer) { create :trainer, expertise_list: ['yoga'] }

        it 'returns a collection of trainers' do
          expect(subject).to be_successful
          expect(json).to eq([expected_trainer_json])
        end
      end

      context 'when mismatching' do
        let!(:trainer) { create :trainer, expertise_list: ['boxing'] }

        it 'returns an empty collection' do
          expect(subject).to be_successful
          expect(json).to eq([])
        end
      end
    end
  end
end
