class FixUniqueContraint < ActiveRecord::Migration[5.2]
  def change
    remove_index :subs, :user_id
    add_index :subs, :user_id
  end
end
