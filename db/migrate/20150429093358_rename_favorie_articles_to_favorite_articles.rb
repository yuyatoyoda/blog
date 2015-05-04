class RenameFavorieArticlesToFavoriteArticles < ActiveRecord::Migration
  def change
    rename_table :favorie_articles, :favorite_articles
  end
end
