class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
#  attr_accessible :name,:email, :password, :password_confirmation, :remember_me
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :articles, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :favorite_articles, dependent: :destroy
  has_many :favorite_comments, dependent: :destroy

  has_many :followings, foreign_key: :follower_id
  has_many :followees, through: :followings
  has_many :follows, foreign_key: :followee_id, class_name: Follow
  has_many :followers, through: :follows

  def followed_by?(user)
    follows.where(follower_id: user.id).exists?
  end
end
