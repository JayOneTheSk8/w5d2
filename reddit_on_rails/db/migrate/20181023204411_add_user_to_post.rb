class AddUserToPost < ActiveRecord::Migration[5.2]
  def change
  end
  add_column :posts, :user_id, :integer
  add_index :posts, :user_id
  add_index :posts, :sub_id
  add_index :posts, :title
  add_index :posts, :url
  add_index :posts, :content
end
