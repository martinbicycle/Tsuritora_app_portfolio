class Tackle < ApplicationRecord
  belongs_to :user
  has_many :post_tackles
  has_many :posts, :through => :post_tackles
end
