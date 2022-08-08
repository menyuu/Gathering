class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.references :end_user, null: false, foreign_key: true
      t.text :text,           null: false
      t.integer :status,      null: false, default: 0

      t.timestamps
    end
  end
end
