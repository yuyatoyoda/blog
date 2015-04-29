class Article < ActiveRecord::Base
  belongs_to :user
  has_many :comments
  has_many :favorite_articles

  def favorited_by? user
    favorite_articles.where(user_id: user.id).exists?
  end
end
