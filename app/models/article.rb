class Article < ActiveRecord::Base
  validates :shinchoku, presence: true
  validates :user_id, presence: true
  validates :date, presence: true
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :favorite_articles, dependent: :destroy

  mount_uploader :article_image, ImageUploader

  def favorited_by?(user)
    favorite_articles.where(user_id: user.id).exists?
  end
end
