class PostTackle < ApplicationRecord
  belongs_to :tackle
  belongs_to :post
end
