class Tag < ApplicationRecord
  has_many :post_tags, dependent: :destroy
  has_many :posts, :through => :post_tags
  validates :name, uniqueness: true


  def self.search_for(content, method)
    Tag.where('name LIKE ?', '%'+content+'%')
  end

end