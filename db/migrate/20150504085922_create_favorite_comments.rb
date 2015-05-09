class CreateFavoriteComments < ActiveRecord::Migration
  def change
    create_table :favorite_comments do |t|
      t.references :user, index: true, foreign_key: true
      t.references :comment, index: true, foreign_key: true

      t.timestamps null: false

      t.index :user_id
      t.index :article_id
      t.index :created_at
    end
  end
end
