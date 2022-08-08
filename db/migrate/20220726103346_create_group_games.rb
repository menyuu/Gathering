class CreateGroupGames < ActiveRecord::Migration[6.1]
  def change
    create_table :group_games do |t|
      t.references :group, null: false, foreign_key: true
      t.references :game, null: false, foreign_key: true

      t.timestamps
    end
  end
end
