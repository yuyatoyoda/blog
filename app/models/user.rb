class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
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
  #mount_uploader :fb_image, FbImageUploader

  def followed_by?(user)
    follows.where(follower_id: user.id).exists?
  end

  def self.find_for_oauth(auth)
    user = User.where(uid: auth.uid, provider: auth.provider).first

    unless user
      user = User.new(
        uid: auth.uid,
        provider: auth.provider,
        email: User.dummy_email(auth),
        password: Devise.friendly_token[0, 20],
        name: auth.extra.raw_info.name,
        fb_image: auth.info.image,
        #token: auth.credentials.token
      )
      user.save(:validation => false)
      p token
    end

    user
  end

  private
  def self.dummy_email(auth)
    "#{auth.uid}-#{auth.provider}@example.com"
  end

end
