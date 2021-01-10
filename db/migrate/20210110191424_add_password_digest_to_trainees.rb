class AddPasswordDigestToTrainees < ActiveRecord::Migration[6.1]
  def change
    add_column :trainees, :password_digest, :string
  end
end
