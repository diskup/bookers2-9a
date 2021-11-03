class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :relationships, foreign_key: :follower_id, dependent: :destroy
  has_many :followers, through: :relationships, source: :followed

  has_many :reverse_of_relationsips, class_name: "Relationship", foreign_key: :followed_id, dependent: :destroy
  has_many :followeds, through: :reverse_of_relationsips, source: :follower

  has_many :book_comments, dependent: :destroy
  has_many :books, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :favorited_users, through: :favorites, source: :user
  attachment :profile_image, destroy: false

  has_many :messages, dependent: :destroy
  has_many :entries, dependent: :destroy

  validates :name, length: {maximum: 20, minimum: 2}, uniqueness: true
  validates :introduction, length: { maximum: 50}
  def is_followed_by?(user)
    reverse_of_relationsips.find_by(follower_id: user.id).present?
  end

end
