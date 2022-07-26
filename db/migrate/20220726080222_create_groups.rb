class CreateGroups < ActiveRecord::Migration[6.1]
  def change
    create_table :groups do |t|
      t.references :owner,  null: false, foreign_key: true
      t.string :name,       null:false
      t.text :introduction, null: false, default: ""

      t.timestamps
    end
  end
end
