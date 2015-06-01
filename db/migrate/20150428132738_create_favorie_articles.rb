class CreateFavorieArticles < ActiveRecord::Migration
  def change
    create_table :favorie_articles do |t|
      t.references :user, index: true, foreign_key: true
      t.references :article, index: true, foreign_key: true

      t.timestamps null: false

#      t.index :user_id
      t.index :article_id
      t.index :created_at
    end
  end
end
