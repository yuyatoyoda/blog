class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :article
  validates :message, presence: :true
  has_many :favorite_comments, dependent: :destroy

  def comment_favorited_by?(user)
    favorite_comments.where(user_id: user.id).exists?
  end
end
