class Follow < ActiveRecord::Base
  belongs_to :follower, class_name: User
  belongs_to :followee, class_name: User

  validates :follower, presence: true
  validates :followee, presence: true
  validates :followee_id, uniqueness: { scope: :follower_id }
  def validate
    if follower_id == followee_id
      errors.add(:followee_id, "自分をフォローすることはできません")
    end
  end
end
