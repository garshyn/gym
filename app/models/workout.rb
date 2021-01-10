# frozen_string_literal: true

class Workout < ApplicationRecord
  belongs_to :creator, class_name: 'Trainer'
  has_and_belongs_to_many :exercises

  enum state: { draft: 'draft', published: 'published' }

  validates :name, presence: true
end
