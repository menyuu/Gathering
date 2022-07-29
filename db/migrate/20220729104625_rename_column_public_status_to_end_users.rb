class RenameColumnPublicStatusToEndUsers < ActiveRecord::Migration[6.1]
  def change
    rename_column :end_users, :public_status, :status
  end
end
