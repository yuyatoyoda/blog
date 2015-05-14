class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
#  attr_accessible :name,:email, :password, :password_confirmation, :remember_me
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable
  has_many :articles, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :favorite_articles, dependent: :destroy
  has_many :favorite_comments, dependent: :destroy

  has_many :followings, foreign_key: :follower_id
  has_many :followees, through: :followings
  has_many :follows, foreign_key: :followee_id, class_name: Follow
  has_many :followers, through: :follows

  mount_uploader :image, ImageUploader

  def followed_by?(user)
    follows.where(follower_id: user.id).exists?
  end

  def self.find_for_oauth(auth)
    user = User.where(uid: auth.uid, provider: auth.provider).first

    unless user
      user = User.create(
        uid: auth.uid,
        provider: auth.provider,
        email: User.dummy_email(auth),
        password: Devise.friendly_token[0, 20]
      )
    end

    user
  end

  private
  def self.dummy_email(auth)
    "#{auth.uid}-#{auth.provider}@example.com"
  end
end
