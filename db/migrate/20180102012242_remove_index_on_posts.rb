class RemoveIndexOnPosts < ActiveRecord::Migration[5.1]
  def change
    remove_index :posts, :user_id
  end
end
