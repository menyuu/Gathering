class RenamePostColumnToPosts < ActiveRecord::Migration[6.1]
  def change
    rename_column :posts, :post, :text
  end
end
