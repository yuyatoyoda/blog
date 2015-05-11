class CreateFollows < ActiveRecord::Migration
  def change
    create_table :follows do |t|
      t.integer :follower_id
      t.integer :followee_id

      t.timestamps null: false

      t.index :follower_id
      t.index :followee_id
    end
  end
end
