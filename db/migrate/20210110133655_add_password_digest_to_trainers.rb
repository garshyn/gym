class AddPasswordDigestToTrainers < ActiveRecord::Migration[6.1]
  def change
    add_column :trainers, :email, :string
    add_column :trainers, :password_digest, :string
    add_index :trainers, :email
  end
end
