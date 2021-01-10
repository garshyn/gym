# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Trainees::Workouts', type: :request do
  subject do
    make_request
    response
  end

  include_context 'when a trainee'

  describe 'GET /index' do
    let(:make_request) { get trainees_workouts_path, headers: headers }
    let!(:trainee_workout) { create :trainee_workout, trainee: trainee }
    let(:expected_trainee_workout_json) do
      {
        'id' => trainee_workout.id,
        'name' => trainee_workout.workout.name,
        'state' => 'assigned'
      }
    end

    it 'returns a collection of workouts' do
      expect(subject).to be_successful
      expect(json).to eq([expected_trainee_workout_json])
    end
  end
end
