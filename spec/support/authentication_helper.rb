# frozen_string_literal: true

shared_context 'when a trainee' do
  let(:headers) { json_header.merge('Authorization' => "Bearer #{token}") }
  let(:token) { JsonWebToken.new(trainee_id: trainee.id).encode }
  let!(:trainee) { create :trainee }
end

shared_context 'when a trainer' do
  let(:headers) { json_header.merge('Authorization' => "Bearer #{token}") }
  let(:token) { JsonWebToken.new(trainer_id: trainer.id).encode }
  let!(:trainer) { create :trainer }
end
