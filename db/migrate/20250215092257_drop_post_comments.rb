class DropPostComments < ActiveRecord::Migration[6.0]
  def up
    drop_table :post_comments
  end

  def down
    create_table :post_comments do |t|
      t.text :comment
      t.integer :user_id
      t.integer :book_id
      t.timestamps
    end
  end
end