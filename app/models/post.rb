class Post < ApplicationRecord

  attachment :image
  geocoded_by :address
  after_validation :geocode, if: :address_changed?

  belongs_to :user
  has_many :tackles, :through => :post_tackles
  has_many :post_tags, dependent: :destroy
  has_many :tags, :through => :post_tags
	has_many :favorites, dependent: :destroy
	has_many :comments, dependent: :destroy

	def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end
  def save_tags(savepost_tags)
      current_tags = self.tags.pluck(:name) unless self.tags.nil?
      old_tags = current_tags - savepost_tags
      new_tags = savepost_tags - current_tags

      old_tags.each do |old_name|
        self.tags.delete Tag.find_by(name: old_name)
      end

      new_tags.each do |new_name|
        post_tag = Tag.find_or_create_by(name: new_name)
        self.tags << post_tag
      end
  end

end
