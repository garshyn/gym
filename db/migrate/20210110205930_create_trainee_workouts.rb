class CreateTraineeWorkouts < ActiveRecord::Migration[6.1]
  def change
    create_table :trainee_workouts do |t|
      t.belongs_to :trainer, null: false, foreign_key: true
      t.belongs_to :trainee, null: false, foreign_key: true
      t.belongs_to :workout, null: false, foreign_key: true
      t.string :state
      t.integer :current_exercise_id
      t.integer :medium_pulse

      t.timestamps
    end
  end
end
