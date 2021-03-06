# frozen_string_literal: true

class CreateTrainees < ActiveRecord::Migration[6.1]
  def change
    create_table :trainees do |t|
      t.string :first_name
      t.string :last_name
      t.string :email, index: { unique: true }

      t.timestamps
    end
  end
end
