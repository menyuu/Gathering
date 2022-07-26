class CreateEndUserGames < ActiveRecord::Migration[6.1]
  def change
    create_table :end_user_games do |t|
      t.references :end_user, null: false, foreign_key: true
      t.references :game, null: false, foreign_key: true

      t.timestamps
    end
  end
end
