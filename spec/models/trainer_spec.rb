# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Trainer, type: :model do
  it { is_expected.to validate_presence_of(:first_name) }
  it { is_expected.to validate_presence_of(:email) }
  it { is_expected.to validate_uniqueness_of(:email).case_insensitive }
  it { is_expected.to have_many(:trainer_selections) }
  it { is_expected.to have_many(:trainees).through(:trainer_selections) }
end
