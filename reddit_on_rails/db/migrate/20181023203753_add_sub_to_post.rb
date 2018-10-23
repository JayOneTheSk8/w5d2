class AddSubToPost < ActiveRecord::Migration[5.2]
  def change
  end
  add_column :posts, :sub_id, :integer
end
