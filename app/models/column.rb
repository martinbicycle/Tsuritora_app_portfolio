class Column < ApplicationRecord
  attachment :image
  belongs_to :admin
end
