class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  validates :name, presence: true
  validates :email, presence: true
  validates :password, presence: true

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable, :omniauth_providers => [:facebook]
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
        token: auth.credentials.token
      )
      user.save(:validation => false)

      #client_id = 'c252d28820074b4c3ecc874cf07258497b948bce6fd2ec377756d18baab530a6'
      #client_secret = '6cd1329b49d4ba4507cf28c3cdbf07985dd7c450aa7d684bc2d729ac207e2666'
      #site = "http://localhost:3000"
      #client = OAuth::User.new(client_id, client_secret, :site => site)
      #token = client.password.get_token(user.email, user.password)
      #user = User.update(
      #  token: token
      #)
    end

    user
  end

  private
  def self.dummy_email(auth)
    "#{auth.uid}-#{auth.provider}@example.com"
  end

end
