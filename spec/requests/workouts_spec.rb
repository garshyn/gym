# frozen_string_literal: true

require 'rails_helper'

describe 'workouts', type: :request do
  subject do
    make_request
    response
  end

  def serialized_workout(workout)
    { 'id' => workout.id, 'name' => workout.name, 'total_duration' => 0 }
  end

  shared_examples 'an error response' do
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

  let(:headers) { json_header.merge('Authorization' => "Bearer #{token}") }
  let(:token) { JsonWebToken.new(trainer_id: trainer.id).encode }
  let!(:trainer) { create :trainer }

  describe 'GET #index action' do
    let(:make_request) { get workouts_path, headers: headers }
    let!(:workout) { create :workout }
    let(:expected_json) do
      [
        serialized_workout(workout)
      ]
    end

    it 'returns a list of workouts' do
      expect(subject).to be_successful
      expect(json).to eq expected_json
    end
  end

  describe '#create action' do
    let(:make_request) { post workouts_path, params: params.to_json, headers: headers }
    let(:params) do
      {
        workout: { name: 'Workout' }
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
        total_duration: 0,
        state: 'draft'
      )
    end

    it_behaves_like 'an error response'
  end

  describe '#show action' do
    let(:make_request) { get workout_path(workout), headers: headers }
    let(:workout) { create :workout }

    it 'returns record data' do
      expect(subject).to be_successful
      expect(json).to eq serialized_workout(workout)
    end
  end

  describe '#update action' do
    let(:make_request) { put workout_path(workout), params: params.to_json, headers: headers }
    let!(:workout) { create :workout }
    let(:params) { { workout: { name: 'New name' } } }

    it 'updates a record' do
      expect do
        expect(subject).to be_successful
      end.to change { workout.reload.name }.from('MyString').to('New name')
    end

    it_behaves_like 'an error response'
  end

  describe '#destroy action' do
    let(:make_request) { delete workout_path(workout), headers: headers }
    let!(:workout) { create :workout }

    it 'destroys a record' do
      expect do
        expect(subject).to be_successful
      end.to change(Workout, :count).by(-1)
    end
  end
end
