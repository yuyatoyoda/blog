class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :article
  validates :message, presence: :true
  has_many :favorite_comments, dependent: :destroy
end
