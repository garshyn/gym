# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Workout, type: :model do
  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to belong_to(:creator) }
  it { is_expected.to have_and_belong_to_many(:exercises) }

  it do
    expect(described_class.new).to define_enum_for(:state).
      with_values(draft: 'draft', published: 'published').
      backed_by_column_of_type(:string)
  end
end
