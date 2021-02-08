class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  attachment :profile_image
  has_many :posts, dependent: :destroy
  has_many :tackles, dependent: :destroy
  has_many :contacts
  has_many :comments, dependent: :destroy
	has_many :favorites, dependent: :destroy
  has_many :reverse_of_relationships, class_name: "Relationship", foreign_key: "following_id", dependent: :destroy
  has_many :relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :followers, through: :reverse_of_relationships, source: :follower
  has_many :followings, through: :relationships, source: :following
  
  def follow(user_id)
    relationships.create(following_id: user_id)
  end

  def unfollow(user_id)
    relationships.find_by(following_id: user_id).destroy
  end

  def following?(user)
    followings.include?(user)
  end

end
