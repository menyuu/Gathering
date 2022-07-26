class CreatePostTags < ActiveRecord::Migration[6.1]
  def change
    create_table :post_tags do |t|
      t.references :post, null: false, foreign_key: true
      t.references :posting_tag, null: false, foreign_key: true

      t.timestamps
    end
  end
end