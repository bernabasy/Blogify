class AddUserRefToLikes < ActiveRecord::Migration[7.0]
  def change
    add_reference :Likes, :author, null: false, foreign_key: { to_table: :users }
  end
end
