class Comment < ApplicationRecord
	belongs_to :user
	belongs_to :post

	validate :add_error

  def add_error
    if body.blank?
      errors[:base] << "コメントが入力されていません"
    end
  end

end
