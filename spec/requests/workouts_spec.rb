# frozen_string_literal: true

require 'rails_helper'

describe 'workouts', type: :request do
  subject do
    make_request
    response
  end

  def serialized_workout(workout)
    { 'id' => workout.id, 'name' => workout.name, 'total_duration' => workout.total_duration }
  end

  shared_examples 'a validation error' do
    context 'with empty name' do
      let(:params) do
        {
          workout: { name: '' }
        }
      end
      let(:error_json) { { 'name' => ["can't be blank"] } }

      it 'returns an error' do
        expect do
          expect(subject).not_to be_successful
          expect(subject).to have_http_status(:unprocessable_entity)
          expect(json).to eq error_json
        end.to change(Workout, :count).by(0)
      end
    end
  end

  shared_examples "an error when accessing other's workout" do
    context 'when workout belongs to other trainer' do
      let!(:workout) { create :workout }

      it 'returns a list of workouts' do
        expect(subject).not_to be_successful
        expect(subject).to have_http_status(:unauthorized)
        expect(json).to eq('error' => 'Record not found')
      end
    end
  end

  let(:headers) { json_header.merge('Authorization' => "Bearer #{token}") }
  let(:token) { JsonWebToken.new(trainer_id: trainer.id).encode }
  let!(:trainer) { create :trainer }
  let(:exercise) { create :exercise, duration: 10 }

  describe 'GET #index action' do
    let(:make_request) { get workouts_path, headers: headers }
    let!(:workout) { create :workout, creator: trainer }
    let(:expected_json) do
      [
        serialized_workout(workout)
      ]
    end

    it 'returns a list of workouts' do
      expect(subject).to be_successful
      expect(json).to eq expected_json
    end

    context 'when workout belongs to other trainer' do
      let!(:workout) { create :workout }

      it 'returns a list of workouts' do
        expect(subject).to be_successful
        expect(json).to eq []
      end
    end
  end

  describe '#create action' do
    let(:make_request) { post workouts_path, params: params.to_json, headers: headers }
    let(:params) do
      {
        workout: { name: 'Workout', exercise_ids: [exercise.id] }
      }
    end
    let(:created_workout) { Workout.last }

    it 'creates a record' do
      expect do
        expect(subject).to be_successful
        expect(json).to eq serialized_workout(created_workout)
      end.to change(Workout, :count).by(1)

      expect(created_workout).to have_attributes(
        name: 'Workout',
        creator: trainer,
        total_duration: 10,
        state: 'draft',
        exercise_ids: [exercise.id]
      )
    end

    it_behaves_like 'a validation error'
  end

  describe '#show action' do
    let(:make_request) { get workout_path(workout), headers: headers }
    let(:workout) { create :workout, creator: trainer }

    it 'returns record data' do
      expect(subject).to be_successful
      expect(json).to eq serialized_workout(workout)
    end

    it_behaves_like "an error when accessing other's workout"
  end

  describe '#update action' do
    let(:make_request) { put workout_path(workout), params: params.to_json, headers: headers }
    let!(:workout) { create :workout, creator: trainer }
    let(:params) { { workout: { name: 'New name', exercise_ids: [exercise.id] } } }

    it 'updates a record' do
      expect do
        expect(subject).to be_successful
      end.to change { workout.reload.name }.from('MyString').to('New name').
        and change { workout.reload.total_duration }.from(0).to(10)
    end

    it_behaves_like 'a validation error'
    it_behaves_like "an error when accessing other's workout"
  end

  describe '#destroy action' do
    let(:make_request) { delete workout_path(workout), headers: headers }
    let!(:workout) { create :workout, creator: trainer }

    it 'destroys a record' do
      expect do
        expect(subject).to be_successful
      end.to change(Workout, :count).by(-1)
    end

    it_behaves_like "an error when accessing other's workout"
  end
end
