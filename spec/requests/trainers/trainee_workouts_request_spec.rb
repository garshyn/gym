# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Trainers::TraineeWorkouts', type: :request do
  subject do
    make_request
    response
  end

  include_context 'when a trainer'

  let!(:trainee) { create :trainee }

  describe 'POST /trainers/trainee_workouts' do
    let(:make_request) { post trainers_trainee_workouts_path, params: params.to_json, headers: headers }
    let(:params) { { trainee_id: trainee.id, workout_id: workout.id } }
    let(:workout) { create :workout }

    it 'creates a record' do
      expect do
        expect(subject).to be_successful
      end.to change(TraineeWorkout, :count).by(1)

      expect(TraineeWorkout.last).to have_attributes(
        trainee: trainee,
        trainer: trainer,
        workout: workout,
        state: 'assigned'
      )
    end
  end

  describe 'DELETE /trainers/trainee_workouts/[id]' do
    let(:make_request) { delete trainers_trainee_workout_path(trainee_workout), headers: headers }
    let!(:trainee_workout) { create :trainee_workout, trainee: trainee, trainer: trainer }

    it 'destroys a record' do
      expect do
        expect(subject).to be_successful
      end.to change(TraineeWorkout, :count).by(-1)
    end
  end
end
