class Contact < ApplicationRecord
  belongs_to :user

  validate :add_error

  def add_error

    # タイトルが空のときにエラーメッセージを追加する
    if title.blank?
      errors[:base] << "タイトルが入力されていません"
    end

    # 本文が空のときにエラーメッセージを追加する
    if body.blank?
      errors[:base] << "内容が入力されていません"
    end

  end


end
