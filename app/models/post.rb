class Post < ApplicationRecord

  belongs_to :user
  has_many :tackles, :through => :post_tackles
  has_many :post_tags, dependent: :destroy
  has_many :tags, :through => :post_tags
	has_many :favorites, dependent: :destroy
	has_many :comments, dependent: :destroy
	has_many :post_tackles


  attr_accessor :tag_names
  attachment :image
  geocoded_by :address
  after_validation :geocode, if: :address_changed?

  validate :add_error

  enum wc: {トイレ：有り: 0, トイレ：無し: 1}
  enum parking: {駐車場：有り: 0, 駐車場：無し: 1}
  enum convenience_store: {コンビニ：有り: 0, コンビニ：無し: 1}
  enum fishing_bait: {釣りエサ屋：有り: 0, 釣りエサ屋：無し: 1}


  def add_error
    # 画像が空のときにエラーメッセージを追加する
    if image.blank?
      errors[:base] << "画像が選択されていません"
    end

    # タイトルが空のときにエラーメッセージを追加する
    if name.blank?
      errors[:base] << "タイトルが入力されていません"
    end

    # 釣った日が空のときにエラーメッセージを追加する
    if fish_time.blank?
      errors[:base] << "釣った日が入力されてません"
    end

  end



  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end

  def save_tags(savepost_tags)
    current_tags = self.tags.pluck(:name) unless self.tags.nil?
    old_tags = current_tags - savepost_tags
    new_tags = savepost_tags - current_tags

    old_tags.each do |old_name|
      self.tags.delete Tag.find_by(name: old_name)
    end

    new_tags.each do |new_name|
      post_tag = Tag.find_or_create_by(name: new_name)
      self.tags << post_tag
    end
  end


  def save_tackles(post_id, savepost_tackles)
    remove_record = PostTackle.where(post_id: post_id)
    remove_record.each do |record|
      record.destroy
    end

    savepost_tackles.each do |tackle|
      next if tackle == ""
      PostTackle.new(post_id: post_id, tackle_id: tackle).save
    end
  end

  def self.search_for(content, method)
    Post.where('name LIKE ?', '%'+content+'%').or(Post.where(
    'address LIKE ?', '%'+content+'%'))
  end
end
