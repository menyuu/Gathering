class CreateGroups < ActiveRecord::Migration[6.1]
  def change
    create_table :groups do |t|
      t.references :owner,  null: false, foreign_key: { to_table: :end_users }
      t.string :name,       null:false
      t.text :introduction, null: false

      t.timestamps
    end
  end
end
