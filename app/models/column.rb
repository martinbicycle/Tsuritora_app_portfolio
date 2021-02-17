class Column < ApplicationRecord
  attachment :image
  belongs_to :admin
  
  validates :title, presence: true
  validates :body, presence: true
  
  def self.search_for(content, method)
    Column.where('title LIKE ?', '%'+content+'%').or(Column.where(
    'body LIKE ?', '%'+content+'%'))
  end

end
