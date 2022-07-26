class CreateGroupGenres < ActiveRecord::Migration[6.1]
  def change
    create_table :group_genres do |t|
      t.references :group, null: false, foreign_key: true
      t.references :genre, null: false, foreign_key: true

      t.timestamps
    end
  end
end
