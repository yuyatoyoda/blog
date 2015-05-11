class AddImageToArticle < ActiveRecord::Migration
  def change
    add_column :articles, :article_image, :string
  end
end
