# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Trainer, type: :model do
  it { is_expected.to validate_presence_of(:first_name) }
end
