class AddSlugToPostsUsersCategories < ActiveRecord::Migration[5.1]
  def change
    add_column :posts, :slug, :string
    add_column :users, :slug, :string
    add_column :categories, :slug, :string
  end
end
