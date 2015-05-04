class FavoriteComment < ActiveRecord::Base
  belongs_to :user
  belongs_to :comment
  validates :user
  validates :user_id, uniqueness: { scope: :comment_id }
  validates :comment
end
