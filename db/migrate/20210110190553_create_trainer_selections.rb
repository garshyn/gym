class CreateTrainerSelections < ActiveRecord::Migration[6.1]
  def change
    create_table :trainer_selections do |t|
      t.belongs_to :trainee, null: false, foreign_key: true
      t.belongs_to :trainer, null: false, foreign_key: true

      t.timestamps
    end
  end
end
