class Post < ApplicationRecord

  attachment :image
  geocoded_by :address
  after_validation :geocode, if: :address_changed?

  belongs_to :user
  has_many :tackles, :through => :post_tackles
  has_many :post_tags
  has_many :tags, :through => :post_tags
	has_many :favorites, dependent: :destroy
	has_many :comments, dependent: :destroy

	def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end

end
