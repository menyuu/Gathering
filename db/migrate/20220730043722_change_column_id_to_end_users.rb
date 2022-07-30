class ChangeColumnIdToEndUsers < ActiveRecord::Migration[6.1]
  def change
    change_column :end_users, :id, :integer
  end
end
