class CreateJoinTableWorkoutExercise < ActiveRecord::Migration[6.1]
  def change
    create_join_table :workouts, :exercises do |t|
      t.index %i[workout_id exercise_id]
    end
  end
end
