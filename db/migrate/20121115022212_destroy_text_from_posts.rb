class DestroyTextFromPosts < ActiveRecord::Migration
  def up
    remove_column :posts, :text
    #remove_column :posts, :tag
    remove_column :posts, :type_id
  end

  def down
    add_column :posts, :text, :string
    add_column :posts, :tag, :string
    add_column :posts, :type_id, :integer
  end
end
