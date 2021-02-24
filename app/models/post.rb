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

  enum state:{
    "---":0,
    北海道:1,青森県:2,岩手県:3,宮城県:4,秋田県:5,山形県:6,福島県:7,
    茨城県:8,栃木県:9,群馬県:10,埼玉県:11,千葉県:12,東京都:13,神奈川県:14,
    新潟県:15,富山県:16,石川県:17,福井県:18,山梨県:19,長野県:20,
    岐阜県:21,静岡県:22,愛知県:23,三重県:24,
    滋賀県:25,京都府:26,大阪府:27,兵庫県:28,奈良県:29,和歌山県:30,
    鳥取県:31,島根県:32,岡山県:33,広島県:34,山口県:35,
    徳島県:36,香川県:37,愛媛県:38,高知県:39,
    福岡県:40,佐賀県:41,長崎県:42,熊本県:43,大分県:44,宮崎県:45,鹿児島県:46,
    沖縄県:47
  }


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
    'address LIKE ?', '%'+content+'%')).or(Post.where(
    'state LIKE ?', '%'+content+'%'))
  end
end
