class FavoriteComment < ActiveRecord::Base
  belongs_to :user
  belongs_to :comment
  validates :user, presence: true
  validates :user_id, uniqueness: { scope: :comment_id }
  validates :comment, presence: true
end
