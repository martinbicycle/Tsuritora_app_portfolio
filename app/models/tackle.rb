class Tackle < ApplicationRecord
  belongs_to :user
  has_many :post_tackles
  has_many :posts, :through => :post_tackles

  validate :add_error

  def add_error
    # 釣り道具が空のときにエラーメッセージを追加する
    if name.blank?
      errors[:base] << "釣り道具が入力されていません"
    end

  end
end
