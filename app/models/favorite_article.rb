class FavoriteArticle < ActiveRecord::Base
  belongs_to :user
  belongs_to :article

  validates :user, presence: true
  validates :user_id, uniqueness: {scope: :article_id}
  validates :article, presence: true
end
