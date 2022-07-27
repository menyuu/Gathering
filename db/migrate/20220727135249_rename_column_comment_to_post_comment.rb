class RenameColumnCommentToPostComment < ActiveRecord::Migration[6.1]
  def change
    rename_column :post_comments, :comment, :text
  end
end
