class AddIndexToUser < ActiveRecord::Migration
  def up
    remove_index :favorite_articles, :user_id
  end

  def down
    add_index :favorite_articles, :user_id
  end
end
