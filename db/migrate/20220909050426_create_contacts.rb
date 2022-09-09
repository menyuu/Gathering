class CreateContacts < ActiveRecord::Migration[6.1]
  def change
    create_table :contacts do |t|
      t.string :name,     null: false
      t.string :email,    null: false
      t.integer :subject, null: false, default: 0
      t.text :message,    null: false
      t.integer :status,  null: false, default: 0

      t.timestamps
    end
  end
end
