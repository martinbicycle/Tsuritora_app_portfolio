class Post < ApplicationRecord

  attachment :image

  belongs_to :user
  has_many :tackles, :through => :post_tackles
  has_many :post_tags
  has_many :tags, :through => :post_tags
	has_many :favorites, dependent: :destroy
	has_many :comments, dependent: :destroy

end
