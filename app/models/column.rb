class Column < ApplicationRecord
  attachment :image
  belongs_to :admin

  def self.search_for(content, method)
    Column.where('title LIKE ?', '%'+content+'%').or(Column.where(
    'body LIKE ?', '%'+content+'%'))
  end

end
