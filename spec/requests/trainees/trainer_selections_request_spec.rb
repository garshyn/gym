require 'rails_helper'

RSpec.describe 'Trainees::TrainerSelections', type: :request do
  subject do
    make_request
    response
  end

  include_context 'when a trainee'

  let!(:trainer) { create :trainer }

  describe 'POST /trainees/trainers/[id]/trainer_selection' do
    let(:make_request) { post trainees_trainer_trainer_selection_path(trainer), headers: headers }

    it 'creates a record' do
      expect do
        expect(subject).to be_successful
      end.to change(TrainerSelection, :count).by(1)

      expect(TrainerSelection.last).to have_attributes(
        trainee: trainee,
        trainer: trainer
      )
    end
  end

  describe 'DELETE /trainees/trainers/[id]/trainer_selection' do
    let!(:trainer_selection) { create :trainer_selection, trainee: trainee, trainer: trainer }
    let(:make_request) { delete trainees_trainer_trainer_selection_path(trainer), headers: headers }

    it 'destroys a record' do
      expect do
        expect(subject).to be_successful
      end.to change(TrainerSelection, :count).by(-1)
    end
  end
end
