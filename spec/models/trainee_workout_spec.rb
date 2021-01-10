# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TraineeWorkout, type: :model do
  it { is_expected.to belong_to(:trainer) }
  it { is_expected.to belong_to(:trainee) }
  it { is_expected.to belong_to(:workout) }

  it do
    expect(described_class.new).to define_enum_for(:state).
      with_values(assigned: 'assigned', started: 'started', canceled: 'canceled', finished: 'finished').
      backed_by_column_of_type(:string)
  end
end
