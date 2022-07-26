class ChangePostingCommentToPostComment < ActiveRecord::Migration[6.1]
  def change
    rename_table :posting_comments, :post_comments
  end
end
