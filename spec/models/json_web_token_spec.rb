# frozen_string_literal: true

require 'rails_helper'

RSpec.describe JsonWebToken, type: :model do
  let(:payload) { { key: 'value' } }

  describe '#encode' do
    let(:token) { described_class.new(payload) }
    let(:encoded_token) { token.encode }

    it 'encodes a payload' do
      expect(encoded_token.split('.')).to match ['eyJhbGciOiJIUzI1NiJ9', anything, anything]
    end
  end

  describe '.decode' do
    let(:encoded_token) { described_class.new(payload).encode }
    let(:token) { described_class.decode(encoded_token) }

    it 'returns a token object' do
      expect(token).to be_a(described_class)
      expect(token.payload.except(:exp)).to eq(payload.with_indifferent_access)
    end
  end
end
