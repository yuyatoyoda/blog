class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  validates :name, presence: true
  validates :email, presence: true
  validates :password, presence: true

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable
  has_many :articles, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :favorite_articles, dependent: :destroy
  has_many :favorite_comments, dependent: :destroy

  #自分がフォロー
  has_many :followings, foreign_key: :follower_id, class_name: Follow, dependent: :destroy
  has_many :followees, through: :followings
  #自分をフォロー
  has_many :follows, foreign_key: :followee_id, class_name: Follow, dependent: :destroy
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
      )
      user.save(:validation => false)
    end

    user
  end

  private
  def self.dummy_email(auth)
    "#{auth.uid}-#{auth.provider}@example.com"
  end

end
