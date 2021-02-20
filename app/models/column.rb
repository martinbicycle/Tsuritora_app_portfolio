class Column < ApplicationRecord
  attachment :image
  belongs_to :admin


  def self.search_for(content, method)
    Column.where('title LIKE ?', '%'+content+'%').or(Column.where(
    'body LIKE ?', '%'+content+'%'))
  end


  validate :add_error

  def add_error

    # タイトルが空のときにエラーメッセージを追加する
    if title.blank?
      errors[:base] << "タイトルが入力されていません"
    end

    # 本文が空のときにエラーメッセージを追加する
    if body.blank?
      errors[:base] << "本文が入力されていません"
    end

  end

end
