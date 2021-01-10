# frozen_string_literal: true

class CreateWorkouts < ActiveRecord::Migration[6.1]
  def change
    create_table :workouts do |t|
      t.string :name
      t.integer :creator_id, null: false
      t.integer :total_duration
      t.string :state

      t.timestamps
    end
    add_index :workouts, :state
    add_index :workouts, :creator_id
  end
end
