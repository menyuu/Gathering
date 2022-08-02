class CreateTags < ActiveRecord::Migration[6.1]
  def change
    create_table :tags do |t|
      t.string :name, null: false
      t.integer :status, null: false, default: 1

      t.timestamps
    end
  end
end
