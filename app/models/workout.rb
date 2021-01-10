# frozen_string_literal: true

class Workout < ApplicationRecord
  belongs_to :creator, class_name: 'Trainer'

  enum state: { draft: 'draft', published: 'published' }

  validates :name, presence: true
end
